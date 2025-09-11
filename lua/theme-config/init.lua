local lualine = require 'lualine'
local poimandres = require('poimandres')
local mini_session = require('mini.sessions')
local mini_starter = require('mini.starter')
local oil = require("oil")
local status_const = require "oil-vcs-status.constant.status"
local colorizer = require 'colorizer'
local scrollbar = require 'scrollbar'
local tabby = require 'tabby'

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

    -- Helper function to get display name for windows in tabby
    local function get_window_display_name(win)
        local buf_name_display
        local bufnr = vim.api.nvim_win_get_buf(win.id)
        -- Use pcall for safety, as buf options might not exist for all buffer types
        local success, is_terminal = pcall(vim.api.nvim_buf_get_option, bufnr, 'buftype')
        is_terminal = success and is_terminal == 'terminal'

        if is_terminal then
            local full_buf_name = vim.api.nvim_buf_get_name(bufnr)
            -- Example: term://.//16010:/bin/zsh
            -- Find the position of the last colon
            local last_colon_idx
            for i = #full_buf_name, 1, -1 do
                if full_buf_name:sub(i, i) == ':' then
                    last_colon_idx = i
                    break
                end
            end

            if last_colon_idx then
                local cmd_part = full_buf_name:sub(last_colon_idx + 1)
                cmd_part = vim.trim(cmd_part)                                  -- Trim whitespace
                -- Split by space and take the first part (the command path)
                local parts = vim.split(cmd_part, '%s+', { trimempty = true }) -- Split by one or more spaces
                if #parts > 0 then
                    -- Get the base name of the command (e.g., /bin/zsh -> zsh)
                    buf_name_display = vim.fn.fnamemodify(parts[1], ':t')
                    -- Handle cases where the command might be empty after extraction
                    if buf_name_display == '' then
                        buf_name_display = 'term' -- Fallback display name
                    end
                else
                    buf_name_display = 'term' -- Fallback if parsing fails
                end
            else
                buf_name_display = 'term' -- Fallback if no colon found
            end
        else
            -- For non-terminal buffers, use the default name provided by tabby
            buf_name_display = win.buf_name()
        end
        return buf_name_display
    end


    local theme = {
        fill = 'TabLineFill',
        -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
        head = 'TabLine',
        current_tab = 'TabLineSel',
        tab = 'TabLine',
        win = 'TabLine',
        tail = 'TabLine',
    }
    vim.o.showtabline = 2
    tabby.setup({
        line = function(line)
            return {
                {
                    { '  ', hl = theme.head },
                    line.sep('', theme.head, theme.fill),
                },
                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current_tab or theme.tab
                    local cwd = ' ' .. vim.fn.fnamemodify(vim.fn.getcwd(0, tab.number()), ':t') .. ' '
                    return {
                        line.sep('', hl, theme.fill),
                        tab.is_current() and '' or '󰆣',
                        tab.number(),
                        cwd,
                        tab.close_btn(''),
                        line.sep('', hl, theme.fill),
                        hl = hl,
                        margin = ' ',
                    }
                end),
                line.spacer(),
                line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                    return {
                        line.sep('', theme.win, theme.fill),
                        win.is_current() and '' or '',
                        get_window_display_name(win), -- Use the helper function here
                        line.sep('', theme.win, theme.fill),
                        hl = theme.win,
                        margin = ' ',
                    }
                end),
                {
                    line.sep('', theme.tail, theme.fill),
                    { '  ', hl = theme.tail },
                },
                hl = theme.fill,
            }
        end,
        -- option = {}, -- setup modules' option,
    })

    scrollbar.setup()

    -- Custom highlights for markdown code snippets in Avante chat windows
    vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#2e3440" })
    vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = "#2e3440" })


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
