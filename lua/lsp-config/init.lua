local masonLspConfig = require("mason-lspconfig")

local lspconfig = require('lspconfig')
local lspSage = require('lspsaga')
local ufo = require('ufo')
-- local origami = require("origami")
--
function get_lang_names()
    -- Determine the full path to your 'langs' directory
    local lang_dir = vim.fn.stdpath("config") .. "/lua/lsp-config/langs"

    -- Read all filenames in that directory
    local files = vim.fn.readdir(lang_dir)
    local languages = {}

    -- Process each file: remove the .lua extension and add the result to languages
    for _, file in ipairs(files) do
        if file:sub(-4) == ".lua" then
            local lang = file:sub(1, -5)
            table.insert(languages, lang)
        end
    end

    return languages
end

local M = {}

M.setup = function()
    local ensure_installed = {}
    local nullLsconfig = {}
    local lsp_config = {}
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- local lsp_flags = {
    --     -- This is the default in Nvim 0.7+
    --     debounce_text_changes = 150,
    -- }
    --

    for _, server_name in ipairs(get_lang_names()) do
        local config = require("lsp-config.langs." .. server_name)
        if config.lsp_config then
            table.insert(ensure_installed, server_name)

            local serverConfig = config.lsp_config or {}
            local setupObject = {
                flags = lsp_flags or {},
                on_attach = function(client, bufnr)
                    local mapping_on_attach = require "lsp-config.mappings".setup()
                    mapping_on_attach()
                    if serverConfig.on_attach then
                        serverConfig.on_attach(client, bufnr)
                    end
                end,
                capabilities = capabilities,
            }

            for key, value in pairs(serverConfig) do
                if key ~= "on_attach" and key ~= "capabilities" then
                    setupObject[key] = value
                end
            end

            lspconfig[server_name].setup(setupObject)
        end
        if config.formatters then
            for _, formatter in pairs(config.formatters) do
                table.insert(nullLsconfig, formatter)
            end
        end
        if config.linters then
            for _, linter in pairs(config.linters) do
                table.insert(nullLsconfig, linter)
            end
        end
    end


    -- Configuring mason
    masonLspConfig.setup {
        ensure_installed = ensure_installed,
        automatic_installation = true
    }

    -- Setup lspsaga
    lspSage.setup {
        code_action = {
            extend_gitsigns = true,
            keys = {
                quit = '<ESC>',
                exec = '<CR>'
            }
        },
        definition = {
            keys = {
                quite = '<ESC>',
            }
        }
    }


    ufo.setup({
        -- provider_selector = function(bufnr, filetype, buftype)
        --     return { 'treesitter', 'indent' }
        -- end,
        enable_get_fold_virt_text = true,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, 'MoreMsg' })
            return newVirtText
        end
    })
    --
    -- origami.setup {
    -- 	keepFoldsAcrossSessions = true,
    -- 	pauseFoldsOnSearch = true,
    -- 	setupFoldKeymaps = true,
    -- }
    --
end


return M
