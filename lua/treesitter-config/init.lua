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
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 200 * 1024 -- 200 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },
        incremental_selection = {
            enable = true
        },
        indent = {
            enable = true
        },
matchup = {
    enable = true
        },

    }
end

return M
