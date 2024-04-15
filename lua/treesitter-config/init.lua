local treesitter = require "nvim-treesitter.configs"

local M = {}

M.setup = function(ensure_installed)
    -- treesitter config
    vim.g.skip_ts_context_commentstring_module = true
    treesitter.setup {
        modules = {},
        sync_install = true,
        ignore_install = {},
        auto_install = true,
        autotag = {
            enable = true
        },
        ts_context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        ensure_installed = ensure_installed,
        highlight = {
            enable = true
        },
        incremental_selection = {
            enable = true
        },
        indent = {
            enable = true
        }
    }
end

return M
