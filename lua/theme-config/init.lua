local lualine = require 'lualine'
local poimandres = require('poimandres')
local mini_session = require('mini.sessions')
local mini_starter = require('mini.starter')
local oil = require("oil")
local status_const = require "oil-vcs-status.constant.status"
local colorizer = require 'colorizer'
local scrollbar = require 'scrollbar'

local StatusType = status_const.StatusType

local M = {}

M.setup = function()
    colorizer.setup()

    vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
            vim.cmd('ColorizerAttachToBuffer')
        end,
        pattern = "*"
    })

    -- vim.api.nvim_create_autocmd("FileType", {
    --     pattern = "*",
    --     command = "setlocal shiftwidth=4 tabstop=4 expandtab"
    -- })
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
    -- vim.api.nvim_set_hl(0, 'Sneak', { fg = 'black', bg = 'red', ctermfg = 'black', ctermbg = 'red' })
    -- vim.api.nvim_set_hl(0, 'SneakScope', { fg = 'red', bg = 'yellow', ctermfg = 'red', ctermbg = 'yellow' })



    vim.cmd('colorscheme poimandres')

    -- vim.opt.termguicolors = true
    -- if vim.fn.has('nvim') then
    --     -- https://github.com/neovim/neovim/wiki/FAQ
    --     vim.opt.guicursor = "n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor"
    -- end
    -- vim.cmd('colorscheme Atelier_SulphurpoolDark')
    --
    lualine.setup {
        options = {
            theme = 'poimandres',
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'diff', 'diagnostics' },
            lualine_c = { 'vim.fn.expand("%:~:.")' },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' }
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
            [StatusType.Added]               = "",
            [StatusType.Copied]              = "󰈢",
            [StatusType.Deleted]             = "󰗨",
            [StatusType.Ignored]             = "",
            [StatusType.Modified]            = "",
            [StatusType.Renamed]             = "",
            [StatusType.TypeChanged]         = "󰉺",
            [StatusType.Unmodified]          = " ",
            [StatusType.Unmerged]            = "",
            [StatusType.Untracked]           = "",
            [StatusType.External]            = "",

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
        },
        status_priority = {
            [StatusType.UpstreamIgnored]     = 0,
            [StatusType.UpstreamUntracked]   = 1,
            [StatusType.UpstreamUnmodified]  = 2,

            [StatusType.UpstreamCopied]      = 3,
            [StatusType.UpstreamRenamed]     = 3,
            [StatusType.UpstreamTypeChanged] = 3,

            [StatusType.UpstreamDeleted]     = 4,
            [StatusType.UpstreamModified]    = 4,
            [StatusType.UpstreamAdded]       = 4,

            [StatusType.UpstreamUnmerged]    = 5,

            [StatusType.Ignored]             = 10,
            [StatusType.Untracked]           = 11,
            [StatusType.Unmodified]          = 12,

            [StatusType.Copied]              = 13,
            [StatusType.Renamed]             = 13,
            [StatusType.TypeChanged]         = 13,

            [StatusType.Deleted]             = 14,
            [StatusType.Modified]            = 14,
            [StatusType.Added]               = 14,

            [StatusType.Unmerged]            = 15,
        },
    }



    vim.api.nvim_set_hl(0, 'OilVcsStatusModified', { fg = '#FBF6D9' })
    vim.api.nvim_set_hl(0, 'OilVcsStatusAdded', { fg = '#89C35C' })
    vim.api.nvim_set_hl(0, 'OilVcsStatusUntracked', { fg = '#FFB8BF' })

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

    scrollbar.setup()


-- Autocomplete icon colors
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { fg = "#C5CDD9", bg = "#22252A" })

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#7E8294", bg = "NONE", strikethrough = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#82AAFF", bg = "NONE", bold = true })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#C792EA", bg = "NONE", italic = true })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#EED8DA", bg = "#B5585F" })
vim.api.nvim_set_hl(0, "CmpItemKindEvent", { fg = "#EED8DA", bg = "#B5585F" })

vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindEnum", { fg = "#C3E88D", bg = "#9FBD73" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#C3E88D", bg = "#9FBD73" })

vim.api.nvim_set_hl(0, "CmpItemKindConstant", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindConstructor", { fg = "#FFE082", bg = "#D4BB6C" })
vim.api.nvim_set_hl(0, "CmpItemKindReference", { fg = "#FFE082", bg = "#D4BB6C" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindStruct", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#EADFF0", bg = "#A377BF" })
vim.api.nvim_set_hl(0, "CmpItemKindOperator", { fg = "#EADFF0", bg = "#A377BF" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#C5CDD9", bg = "#7E8294" })
vim.api.nvim_set_hl(0, "CmpItemKindFile", { fg = "#C5CDD9", bg = "#7E8294" })

vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindSnippet", { fg = "#F5EBD9", bg = "#D4A959" })
vim.api.nvim_set_hl(0, "CmpItemKindFolder", { fg = "#F5EBD9", bg = "#D4A959" })

vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindValue", { fg = "#DDE5F5", bg = "#6C8ED4" })
vim.api.nvim_set_hl(0, "CmpItemKindEnumMember", { fg = "#DDE5F5", bg = "#6C8ED4" })

vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindColor", { fg = "#D8EEEB", bg = "#58B5A8" })
vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#D8EEEB", bg = "#58B5A8" })

end

return M
