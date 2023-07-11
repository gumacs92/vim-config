
local lualine = require'lualine'
local poimandres = require('poimandres')
local nvim_tree = require'nvim-tree'

local M = {}

M.setup = function()

    poimandres.setup {
        bold_vert_split = true, -- use bold vertical separators
        dim_nc_background = true, -- dim 'non-current' window backgrounds
        disable_background = false, -- disable background
        disable_float_background = false, -- disable background for floats
        disable_italics = false, -- disable italics
    }

    vim.cmd('colorscheme poimandres')
    lualine.setup {
        options = {
            theme = 'poimandres'
        },
    }

    nvim_tree.setup {
        sync_root_with_cwd = true,
        git = {
            ignore = false,
        },
        -- renderer = {
        --     icons = {
        --         padding = " ",
        --         glyphs = {
        --             folder = {
        --               arrow_closed = "➡️",
        --               arrow_open = "⬇️",
        --               default = "📁",
        --               open = "📂",
        --               empty = "📁",
        --               empty_open = "📂",
        --               symlink = "🔗",
        --               symlink_open = "🔗",
        --             },
        --             git = {
        --               unstaged = "❌",
        --               staged = "✅",
        --               unmerged = "🔀",
        --               renamed = "📝",
        --               untracked = "🌟",
        --               deleted = "➖",
        --               ignored = "⭕",
        --             }
        --         }
        --     }
    -- }
    }

end

return M
