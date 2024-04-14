local lualine = require 'lualine'
local poimandres = require('poimandres')
local nvim_tree = require 'nvim-tree'
local mini_session = require('mini.sessions')
local mini_starter = require('mini.starter')

local M = {}

M.setup = function()
    poimandres.setup {
        bold_vert_split = true,           -- use bold vertical separators
        dim_nc_background = true,         -- dim 'non-current' window backgrounds
        disable_background = false,       -- disable background
        disable_float_background = false, -- disable background for floats
        disable_italics = false,          -- disable italics
    }

-- hi ActiveWindow guibg=#21242b
-- hi InactiveWindow guibg=#282C34
-- highlight Sneak guifg=black guibg=red ctermfg=black ctermbg=red
-- highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow
--
-- " TODO replace magent with somtehing more styliest
    vim.api.nvim_set_hl(0, 'ActiveWindow', { bg = '#21242b' })
    vim.api.nvim_set_hl(0, 'InactiveWindow', { bg = '#282C34' })
    vim.api.nvim_set_hl(0, 'Sneak', { fg = 'black', bg = 'red', ctermfg = 'black', ctermbg = 'red' })
    vim.api.nvim_set_hl(0, 'SneakScope', { fg = 'red', bg = 'yellow', ctermfg = 'red', ctermbg = 'yellow' })

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

    local header_art =
    [[
     ╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮
     │││├┤ │ │╰┐┌╯││││
     ╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴
    ]]

    -- using the mini plugins
    mini_session.setup({
        -- Whether to read latest session if Neovim opened without file arguments
        autoread = false,
        -- Whether to write current session before quitting Neovim
        autowrite = false,
        -- Directory where global sessions are stored (use `''` to disable)
        directory = '~/.local/state/nvim/sessions', --<"session" subdir of user data directory from |stdpath()|>,
        -- File for local session (use `''` to disable)
        file = ''                                   -- 'Session.vim',
    })


    mini_starter.setup({
        -- evaluate_single = true,
        items = {
            mini_starter.sections.sessions(77, true),
            mini_starter.sections.builtin_actions(),
        },
        content_hooks = {
            function(content)
                local blank_content_line = { { type = 'empty', string = '' } }
                local section_coords = mini_starter.content_coords(content, 'section')
                -- Insert backwards to not affect coordinates
                for i = #section_coords, 1, -1 do
                    table.insert(content, section_coords[i].line + 1, blank_content_line)
                end
                return content
            end,
            mini_starter.gen_hook.adding_bullet("» "),
            mini_starter.gen_hook.aligning('center', 'center'),
        },
        header = header_art,
        footer = '',
    })
end

return M
