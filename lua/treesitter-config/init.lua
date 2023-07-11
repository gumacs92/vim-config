
local treesitter = require"nvim-treesitter.configs"

local M = {}

M.setup = function (ensure_installed)
    -- treesitter config
    treesitter.setup {
        auto_install = true,
        autotag = {
            enable = true
        },
        context_commentstring = {
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
    }

end

return M
