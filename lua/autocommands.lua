local M = {}

M.setup = function()
    -- autocmd FileType * setlocal shiftwidth=4 tabstop=4 expandtab
    -- autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 expandtab
    -- autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab
    -- autocmd FileType json setlocal shiftwidth=2 tabstop=2 expandtab
    -- autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 expandtab
    -- autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2 expandtab
    -- autocmd FileType vue setlocal shiftwidth=2 tabstop=2 expandtab
    --
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        command = "setlocal shiftwidth=4 tabstop=4 expandtab"
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "typescript",
        command = "setlocal shiftwidth=2 tabstop=2 expandtab"
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "javascript",
        command = "setlocal shiftwidth=2 tabstop=2 expandtab"
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "json",
        command = "setlocal shiftwidth=2 tabstop=2 expandtab"
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "typescriptreact",
        command = "setlocal shiftwidth=2 tabstop=2 expandtab"
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "javascriptreact",
        command = "setlocal shiftwidth=2 tabstop=2 expandtab"
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "vue",
        command = "setlocal shiftwidth=2 tabstop=2 expandtab"
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "*.yml,*.yaml",
        command = "setlocal shiftwidth=2 tabstop=2 expandtab"
    })

    vim.api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        command = "silent! lua vim.highlight.on_yank()"
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*",
        -- group = "FormatAutogroup",
        command = "lua formatCode()"
    })

    vim.api.nvim_create_user_command('Files', function(opts)
        -- Building the options string from Lua
        local fzf_options = '--layout=reverse --info=inline --preview ~/.config/nvim/plugged/fzf.vim/bin/preview.sh\\ {}'
        -- Use vim.fn to call the vim function
        vim.fn['fzf#vim#files'](opts.args, { options = fzf_options }, opts.bang)
    end, { nargs = '?', complete = 'dir', bang = true })
    vim.cmd([[ runtime macros/sandwich/keymap/surround.vim ]])

    local function convert_mysql_url(url)
        -- If it already starts with "mysql://", assume it's in Dadbod format.
        if url:match("^mysql://") then
            return url
        end
        -- Try to match the Go-style MySQL connection string.
        local userpass, host, port, db = url:match("^(.-)@tcp%((.-):(.-)%)/(.+)$")
        if userpass and host and port and db then
            print("Returning: " .. "mysql://" .. userpass .. "@" .. host .. ":" .. port .. "/" .. db .. "?protocol=tcp")
            return "mysql://" .. userpass .. "@" .. host .. ":" .. port .. "/" .. db .. "?protocol=tcp"
        end
        -- For non-MySQL or unrecognized formats, return unchanged.
        return url
    end

    -- vim.api.nvim_create_autocmd("FileType", {
    --     pattern = "sql",
    --     callback = function()
    --         require 'dbee'.api.core.register_event_listener('current_connection_changed', function(params)
    --             local activeConnection = require 'dbee'.api.core.get_current_connection()
    --             if activeConnection then
    --                 print("Active connection")
    --                 print(vim.inspect(activeConnection))
    --                 vim.g.db = activeConnection.url
    --                 vim.cmd('DB ' .. convert_mysql_url(activeConnection.url))
    --                 vim.cmd('DBCompletionClearCache')
    --             end
    --         end)
    --     end
    -- })


    -- " set foldmethod=expr
    -- " set foldexpr=nvim_treesitter#foldexpr()
    -- " autocmd BufReadPost,FileReadPost * normal zR
end

return M
