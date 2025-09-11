local M = {}

local oil = require("oil")
local aider = require("nvim_aider")
local snacks_terminal = require("snacks.terminal")

-- Patch snacks.terminal.get to include the current tab id in its key.
-- This seems necessary for aider's terminal management per tab.
local original_get = snacks_terminal.get
local function generate_tab_specific_key(cmd, opts)
    -- Get current tabpage id as a string (this will be unique per tab)
    local tab_id = vim.api.nvim_get_current_tabpage()
    local tab_number = vim.api.nvim_tabpage_get_number(tab_id)
    local concat = table.concat({ tostring(tab_id), cmd, vim.fn.getcwd(0, tab_number) }, ":")
    vim.print("Tab id: " .. tab_id, tab_number)

    return concat
end

snacks_terminal.get = function(cmd, opts)
    opts = opts or {}
    -- Override the key using the current tab id.
    -- opts.create = true
    -- vim.print(vim.inspect(opts))
    -- vim.print(vim.inspect(cmd))
    local tab_id = vim.api.nvim_get_current_tabpage()
    -- opts.key = generate_tab_specific_key(cmd .. tab_id, opts)
    return original_get(cmd .. tab_id, opts)
end


local function add_path_to_aider(full_path)
    if vim.fn.isdirectory(full_path) == 1 then
        -- It's a directory, recursively add files
        print("Adding directory recursively: " .. full_path)
        -- Use globpath to find all files recursively. '**' matches recursively. '*' matches files.
        -- The '1' at the end returns a list. The '1' before that includes files starting with '.'
        local files_in_dir = vim.fn.globpath(full_path, '**/*', 1, 1)
        -- Filter out directories from the list, keeping only files
        local files_to_add = {}
        for _, file_path in ipairs(files_in_dir) do
            if vim.fn.isdirectory(file_path) == 0 then
                table.insert(files_to_add, file_path)
            end
        end
        if #files_to_add > 0 then
            require('nvim_aider.terminal').command('/add', table.concat(files_to_add, " "))
        else
            print("No files found in directory: " .. full_path)
        end
    else
        -- It's a file, add it directly
        if vim.fn.filereadable(full_path) == 1 then
            print("Adding file: " .. full_path)
            require('nvim_aider.terminal').command('/add', full_path)
        else
            print("Skipping non-readable file/entry: " .. full_path)
        end
    end
end

local function add_path_to_aider_readonly(full_path)
    if vim.fn.isdirectory(full_path) == 1 then
        print("Adding directory recursively as read-only: " .. full_path)
        local files_in_dir = vim.fn.globpath(full_path, '**/*', 1, 1)
        local files_to_add = {}
        for _, file_path in ipairs(files_in_dir) do
            if vim.fn.isdirectory(file_path) == 0 then
                table.insert(files_to_add, file_path)
            end
        end
        if #files_to_add > 0 then
            require('nvim_aider.terminal').command('/add', '--read-only ' .. table.concat(files_to_add, " "))
        else
            print("No files found in directory: " .. full_path)
        end
    else
        if vim.fn.filereadable(full_path) == 1 then
            print("Adding file as read-only: " .. full_path)
            require('nvim_aider.terminal').command('/add', '--read-only ' .. full_path)
        else
            print("Skipping non-readable file/entry: " .. full_path)
        end
    end
end

local function drop_path_from_aider(full_path)
    if vim.fn.isdirectory(full_path) == 1 then
        print("Dropping directory recursively: " .. full_path)
        local files_in_dir = vim.fn.globpath(full_path, '**/*', 1, 1)
        local files_to_drop = {}
        for _, file_path in ipairs(files_in_dir) do
            if vim.fn.isdirectory(file_path) == 0 then
                table.insert(files_to_drop, file_path)
            end
        end
        if #files_to_drop > 0 then
            require('nvim_aider.terminal').command('/drop', table.concat(files_to_drop, " "))
        else
            print("No files found in directory: " .. full_path)
        end
    else
        if vim.fn.filereadable(full_path) == 1 then
            print("Dropping file: " .. full_path)
            require('nvim_aider.terminal').command('/drop', full_path)
        else
            -- Dropping non-readable might still be valid if aider knows about it, but let's be consistent
            print("Skipping non-readable file/entry for drop: " .. full_path)
        end
    end
end

M.send_from_oil = function()
    local mode = vim.fn.mode()
    if mode == 'v' or mode == 'V' then
        local current_dir = oil.get_current_dir()
        local start_line = vim.fn.getpos("v")[2]
        local end_line = vim.fn.getcurpos()[2]
        if start_line > end_line then start_line, end_line = end_line, start_line end

        for i = start_line, end_line do
            local entry_name = vim.fn.getline(i)
            local full_path = current_dir .. entry_name
            add_path_to_aider(full_path)
        end
    else -- Normal mode
        local current_dir = oil.get_current_dir()
        local entry = oil.get_cursor_entry()
        if not entry then
            print("Could not get entry under cursor.")
            return
        end
        local full_path = current_dir .. entry.name
        add_path_to_aider(full_path)
    end
end

M.send_from_oil_readonly = function()
    local mode = vim.fn.mode()
    if mode == 'v' or mode == 'V' then
        local current_dir = oil.get_current_dir()
        local start_line = vim.fn.getpos("v")[2]
        local end_line = vim.fn.getcurpos()[2]
        if start_line > end_line then start_line, end_line = end_line, start_line end

        for i = start_line, end_line do
            local entry_name = vim.fn.getline(i)
            local full_path = current_dir .. entry_name
            add_path_to_aider_readonly(full_path)
        end
    else -- Normal mode
        local current_dir = oil.get_current_dir()
        local entry = oil.get_cursor_entry()
        if not entry then
            print("Could not get entry under cursor.")
            return
        end
        local full_path = current_dir .. entry.name
        add_path_to_aider_readonly(full_path)
    end
end

M.drop_from_oil = function()
    local mode = vim.fn.mode()
    if mode == 'v' or mode == 'V' then
        local current_dir = oil.get_current_dir()
        local start_line = vim.fn.getpos("v")[2]
        local end_line = vim.fn.getcurpos()[2]
        if start_line > end_line then start_line, end_line = end_line, start_line end

        for i = start_line, end_line do
            local entry_name = vim.fn.getline(i)
            local full_path = current_dir .. entry_name
            drop_path_from_aider(full_path)
        end
    else -- Normal mode
        local current_dir = oil.get_current_dir()
        local entry = oil.get_cursor_entry()
        if not entry then
            print("Could not get entry under cursor.")
            return
        end
        local full_path = current_dir .. entry.name
        drop_path_from_aider(full_path)
    end
end

M.setup = function()
    aider.setup({
        -- theme = "poimandres",
        args = {
            "--model=gemini",
            "--vim",
            "--watch-files",
            "--no-auto-commits",
            "--pretty",
            "--stream",
        },

        win = {
            resize = true,
            width = 0.3,
            start_insert = false,
            auto_insert = false,
            auto_close = true,
            wo = {
                winbar = "Aider",
                -- width = '0.3'
            },
            style = "nvim_aider",
            position = "right",
            on_win = function()
                vim.cmd("wincmd =")
            end
        },
        theme = {
            user_input_color = "#CDD3DE",
            tool_output_color = "#8aadf4",
            -- tool_error_color = "#ed8796",
            tool_warning_color = "#eed49f",
            assistant_output_color = "#c6a0f6",
            completion_menu_color = "#cad3f5",
            completion_menu_bg_color = "#292D3E",
            completion_menu_current_color = "#CDD3DE",
            completion_menu_current_bg_color = "#8aadf4",
        },
    })

    vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
            if vim.bo.buftype == "terminal" then
                vim.cmd("stopinsert")
            end
        end,
    })

    -- Define key mappings
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map('n', '<leader>a/', '<cmd>AiderTerminalToggle<cr>', { desc = "Open Aider", noremap = true, silent = true })
    map({ 'n', 'v' }, '<leader>as', '<cmd>AiderTerminalSend<cr>',
        { desc = "Send to Aider", noremap = true, silent = true })
    map('n', '<leader>ac', '<cmd>AiderQuickSendCommand<cr>',
        { desc = "Send Command To Aider", noremap = true, silent = true })
    map('n', '<leader>ab', '<cmd>AiderQuickSendBuffer<cr>',
        { desc = "Send Buffer To Aider", noremap = true, silent = true })

    -- Consolidated mappings for Add/Drop/ReadOnly (works in Oil too)
    map('n', '<leader>a+', function()
        if vim.bo.filetype == 'oil' then
            require('aider').send_from_oil()
        else
            vim.cmd('AiderQuickAddFile')
        end
    end, { desc = "Add File (Oil/Normal)", noremap = true, silent = true })
    map('n', '<leader>a-', function()
        if vim.bo.filetype == 'oil' then
            require('aider').drop_from_oil()
        else
            vim.cmd('AiderQuickDropFile')
        end
    end, { desc = "Drop File (Oil/Normal)", noremap = true, silent = true })
    map('n', '<leader>ar', function()
        if vim.bo.filetype == 'oil' then
            require('aider').send_from_oil_readonly()
        else
            vim.cmd('AiderQuickReadOnlyFile')
        end
    end, { desc = "Add Read-Only (Oil/Normal)", noremap = true, silent = true })

    -- Removed old Oil specific mappings

    vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
            if vim.bo.buftype == "terminal" then
                vim.cmd("stopinsert")
            end
        end,
    })
end

return M
