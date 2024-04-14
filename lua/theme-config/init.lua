local lualine = require 'lualine'
local poimandres = require('poimandres')
-- local nvim_tree = require 'nvim-tree'
local mini_session = require('mini.sessions')
local mini_starter = require('mini.starter')
local oil = require("oil")
local status_const = require "oil-vcs-status.constant.status"

local StatusType = status_const.StatusType

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
    oil.setup {
        win_options = {
            signcolumn = "yes:2",
        },
        show_ignored = true,
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.preview",
            ["<C-v>"] = "actions.select_vsplit",
            ["<C-x>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-c>"] = function()
                oil.discard_all_changes()
                oil.close()
            end,
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gr"] = "actions.refresh",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
        },
        use_default_keymaps = false
    }
    require "oil-vcs-status".setup {
        -- Executable path of each version control system.
        vcs_executable = {
            git = "git",
            svn = "svn",
        },
        status_symbol = {
            [StatusType.Added]               = "",
            [StatusType.Copied]              = "󰆏",
            [StatusType.Deleted]             = "撍",
            [StatusType.Ignored]             = "",
            [StatusType.Modified]            = "",
            [StatusType.Renamed]             = "",
            [StatusType.TypeChanged]         = "󰉺",
            [StatusType.Unmodified]          = " ",
            [StatusType.Unmerged]            = "",
            [StatusType.Untracked]           = "鑹",
            [StatusType.External]            = "",

            [StatusType.UpstreamAdded]       = "󰈞",
            [StatusType.UpstreamCopied]      = "󰈢",
            [StatusType.UpstreamDeleted]     = "",
            [StatusType.UpstreamIgnored]     = " ",
            [StatusType.UpstreamModified]    = "󰏫",
            [StatusType.UpstreamRenamed]     = "",
            [StatusType.UpstreamTypeChanged] = "󱧶",
            [StatusType.UpstreamUnmodified]  = " ",
            [StatusType.UpstreamUnmerged]    = "",
            [StatusType.UpstreamUntracked]   = " ",
            [StatusType.UpstreamExternal]    = "",
        }
    }

    -- nvim_tree.setup {
    --     view = {
    --         adaptive_size = true
    --     },
    --     sync_root_with_cwd = true,
    --     git = {
    --         ignore = false,
    --     },
    -- }

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
