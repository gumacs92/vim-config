local utils = require('utils')

local M = {}

local api = vim.api
local fn = vim.fn
local uv = vim.loop

local ns_id             -- Namespace for virtual text
local translations = {} -- Cache for loaded translations { locale = { key = value } }
local project_root = nil
local locales_dir = nil
local debounce_timer = nil
local debounce_ms = 500 -- Debounce updates by 500ms

-- Planned configuration options:
local config = {
    -- show_virtual_text = true,        -- Show virtual text
    show_on_hover = true,            -- Show translations on hover
    translate_function = 't',
    show_all_translations = false,   -- Show all translations
    show_translations = {},          -- Show translations for these locales, e.g. { "en", "fr" }
    show_default_translation = true, -- Show default translation
    max_length = 50,                 -- Max length of translation to show
}

-- Find project root containing .git directory
local function find_project_root()
    -- print("[DEBUG] Entering find_project_root")
    print("Finding project root...")
    local current_dir = fn.expand('%:p:h')
    local marker = '.git'
    local root = fn.finddir(marker, current_dir .. ';')
    if root == '' or root == nil then
        return nil
    end
    -- print("[DEGUG] Found marker directory: " .. root)
    -- Go one level up from the marker directory
    local result = fn.fnamemodify(root, ':p:h:h')

    -- print("[DEBUG] Project root found: " .. result)
    return result
end

-- Check if locales directory exists
local function check_locales_dir()
    -- print("[DEBUG] Entering check_locales_dir")
    -- print("Checking for locales directory...")
    if not project_root then
        -- print("[DEBUG] check_locales_dir: project_root is nil")
        return nil
    end
    -- print("Project root: " .. project_root)
    local potential_locales_dir = project_root .. '/locales'
    local stat = uv.fs_stat(potential_locales_dir)
    -- print("[DEBUG] check_locales_dir: potential_locales_dir: " .. potential_locales_dir)
    if stat and stat.type == 'directory' then
        -- print("Found locales directory: " .. potential_locales_dir)
        return potential_locales_dir
    end
    return nil
end

-- Load translations from JSON files in the locales directory
local function load_translations()
    -- print("[DEBUG] Entering load_translations")
    translations = {} -- Clear cache
    if not locales_dir then
        -- print("[DEBUG] load_translations: locales_dir is nil")
        print("No locales directory found.")
        return
    end

    -- local files = {}
    local locale_files = vim.fs.find(function(name, path)
        -- print("[DEBUG] Checking file: " .. name, path, vim.inspect(name:match('%.json$')))
        return name:match('%.json$')
    end, { path = locales_dir, type = "file", limit = 1000 })

    -- print("[DEBUG] Found locale files: ", vim.inspect(locale_files))

    if #locale_files > 0 then
        for _, file in ipairs(locale_files) do
            local locale = fn.fnamemodify(file, ':t:r') -- Use filename without extension as locale
            local content = table.concat(fn.readfile(file), '\n')
            local ok, data = pcall(fn.json_decode, content)

            -- local namespace = file:match('locales/(.+)/')
            -- local namespace_split = namespace and vim.split(namespace, '/', { trimempty = true, plain = true }) or {}
            --
            -- for i, part in ipairs(namespace_split) do
            --     if i == #namespace_split then
            --         locale = part
            --     else
            --         locale = locale .. "_" .. part
            --     end
            -- end

            if ok and type(data) == 'table' then
                translations[locale] = utils.mergeTables(translations[locale] or {}, data)
                -- print("Loaded translations for locale: " .. locale, vim.inspect(data))
            else
                vim.notify("Error decoding JSON: " .. file, vim.log.levels.WARN)
            end
        end
        return
    end
end

-- Truncate text if it exceeds max_len
local function truncate_text(text, max_len)
    -- print("[DEBUG] Entering truncate_text. text: ", text, " max_len: ", max_len)
    if text and #text > max_len then
        return text:sub(1, max_len) .. "..."
    end
    return text or ""
end

-- Update virtual text for the current buffer
local function update_virtual_text(bufnr)
    -- print("[DEBUG] Entering update_virtual_text. bufnr: ", bufnr)
    bufnr = bufnr or api.nvim_get_current_buf()
    -- print("[DEBUG] update_virtual_text: Effective bufnr: ", bufnr)

    -- Clear existing virtual text from this plugin
    api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

    -- Only proceed if we have translations
    if vim.tbl_isempty(translations) then
        -- print("[DEBUG] update_virtual_text: No translations loaded, skipping update")
        return
    end

    local lines = api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local pattern = "t%(%s*['\"]([^'\"]+)['\"]%s*%)" -- Matches t('key') or t("key")

    for i, line in ipairs(lines) do
        for key_match in line:gmatch(pattern) do
            local display_texts = {}
            for locale, locale_translations in pairs(translations) do
                -- print("[DEBUG] Checking locale: " .. locale .. " for key: " .. key_match,
                --     vim.inspect(locale_translations))

                local key_parts = vim.split(key_match, ".", { trimempty = true, plain = true })
                local translation_sub_section = locale_translations
                -- print("[DEBUG] Key parts: ", vim.inspect(key_parts))
                -- print("[DEBUG] Translation sub-section: ", vim.inspect(translation_sub_section))
                for j, key_part in ipairs(key_parts) do
                    -- print("[DEBUG] Processing key part: " .. key_part)
                    if translation_sub_section[key_part] then
                        if j == #key_parts then
                            -- Last part of the key, get the value
                            local truncated = truncate_text(translation_sub_section[key_part], 50)
                            -- print("[DEBUG] Found translation for key: " ..
                            -- key_match .. " in locale: " .. locale .. " -> " .. truncated)
                            table.insert(display_texts, locale .. ": " .. truncated)
                            -- translation_sub_section = translation_sub_section[key_part]
                        else
                            -- Intermediate part of the key, navigate deeper
                            -- print("[DEBUG] Found sub-section: ", vim.inspect(translation_sub_section[key_part]))
                            if type(translation_sub_section[key_part]) ~= "table" then
                                translation_sub_section = nil
                                break
                            else
                                translation_sub_section = translation_sub_section[key_part]
                            end
                        end
                    end
                end
            end

            if #display_texts > 0 then
                local virt_text = table.concat(display_texts, " | ")
                -- Find the column of the match to place the virtual text
                -- This is approximate, placing it at the end of the line for simplicity now
                -- A more precise approach would use match positions or Tree-sitter
                api.nvim_buf_set_virtual_text(bufnr, ns_id, i - 1, { { virt_text, "Comment" } }, {})
                -- Only show one virtual text per line for now, break after first match
                break
            end
        end
    end
end


-- Debounced version of update_virtual_text
local function debounced_update(bufnr)
    -- print("[DEBUG] Entering debounced_update. bufnr: ", bufnr)
    if debounce_timer then
        -- print("[DEBUG] debounced_update: Closing existing timer")
        debounce_timer:close()
    end
    debounce_timer = uv.new_timer()
    debounce_timer:start(debounce_ms, 0, vim.schedule_wrap(function()
        update_virtual_text(bufnr)
    end))
end

-- Setup function for the plugin
M.setup = function()
    -- print("[DEBUG] Entering M.setup")
    ns_id = api.nvim_create_namespace("i18n_nvim")
    -- print("[DEBUG] M.setup: Created namespace id: ", ns_id)

    local i18n_group = api.nvim_create_augroup("I18nNvim", { clear = true })
    -- print("[DEBUG] M.setup: Created augroup I18nNvim")

    api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
        group = i18n_group,
        pattern = "*",
        callback = function(args)
            -- print("[DEBUG] BufEnter/DirChanged callback triggered. args: ", vim.inspect(args))
            local new_root = find_project_root()
            project_root = new_root
            locales_dir = check_locales_dir()
            if locales_dir then
                load_translations()
                update_virtual_text(args.buf)                            -- Update immediately on entering a buffer in a new project
            else
                translations = {}                                        -- Clear translations if no locales dir
                if api.nvim_buf_is_valid(args.buf) then
                    api.nvim_buf_clear_namespace(args.buf, ns_id, 0, -1) -- Clear virtual text
                end
            end
        end,
    })

    api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
        group = i18n_group,
        pattern = "*",
        callback = function(args)
            -- print("[DEBUG] TextChanged/TextChangedI callback triggered. args: ", vim.inspect(args))
            if locales_dir then -- Only run if locales dir exists for the project
                -- print("[DEBUG] TextChanged/TextChangedI: locales_dir exists, calling debounced_update")
                debounced_update(args.buf)
            else
                -- print("[DEBUG] TextChanged/TextChangedI: locales_dir does not exist, skipping update")
            end
        end,
    })

    api.nvim_create_autocmd({ "BufWritePost" }, {
        group = i18n_group,
        pattern = "**/locales/**/*.json", -- Reload translations if a locale file is saved
        callback = function(args)
            -- print("[DEBUG] BufWritePost locales callback triggered. args: ", vim.inspect(args))
            if locales_dir then
                -- print("[DEBUG] BufWritePost: locales_dir exists, reloading translations and updating buffers")
                load_translations()
                -- Update virtual text for all visible buffers
                for _, win in ipairs(api.nvim_list_wins()) do
                    local buf = api.nvim_win_get_buf(win)
                    update_virtual_text(buf)
                end
            end
        end,
    })

    -- Initial check for current buffer
    vim.defer_fn(function()
        -- print("[DEBUG] Entering deferred initial check function")
        project_root = find_project_root()
        locales_dir = check_locales_dir()
        if locales_dir then
            -- print("[DEBUG] Deferred check: locales_dir found, loading translations and updating current buffer")
            load_translations()
            update_virtual_text(api.nvim_get_current_buf())
        end
    end, 100) -- Defer initial check slightly

    print("i18n.nvim setup complete", vim.inspect({
        project_root = project_root,
        locales_dir = locales_dir,
        translations = translations,
    }))
end

return M
