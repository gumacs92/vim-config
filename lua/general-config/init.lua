local telescope = require "telescope"
local nvim_autopairs = require "nvim-autopairs"
local comment = require "Comment"
local commentstring = require 'ts_context_commentstring.integrations.comment_nvim'
local bufdel = require 'bufdel'
local ufo = require 'ufo'
local harpoon = require 'harpoon'
local autoSession = require 'auto-session'

local M = {}

M.setup = function()
    vim.opt.switchbuf = "usetab,vsplit" -- Allow switching to buffers not currently open in a window

    vim.g['loaded_netrw'] = 1
    vim.g['loaded_netrwPlugin'] = 1

    nvim_autopairs.setup()

    -- numtoStr/Comment setup
    comment.setup {
        --     ignore = '^$',
        pre_hook = commentstring.create_pre_hook()
    }

    bufdel.setup {
        quit = false
    }

    vim.diagnostic.config({
        virtual_text = true,
        virtual_lines = false,
        signs = true,
        underline = true,
        -- update_in_insert = true,
        severity_sort = true,
    })

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
    -- local M = {}

    local icons = {
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Enum = "了 ",
        EnumMember = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = "ﰮ ",
        Keyword = " ",
        Method = "ƒ ",
        Module = " ",
        Property = " ",
        Snippet = "﬌ ",
        Struct = " ",
        Text = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
    }
    -- function M.setup()
    local kinds = vim.lsp.protocol.CompletionItemKind
    for i, kind in ipairs(kinds) do
        kinds[i] = icons[kind] or kind
    end
    -- end


    autoSession.setup({
        auto_restore = true,
        auto_create = true,
        auto_save = true,
        bypass_session_save_file_types = { "gitcommit" },
        cwd_change_handling = true,
        allowed_dirs = {
            '/home/gumacs/dev/*'
        }
    })



    -- Configuring Telescope plugin
    telescope.setup {
        defaults = {
            preview_cutoff = 200,
            file_ignore_patterns = {
                "node_modules",
                "dist",
                "build",
                "target",
                "vendor",
                "yarn.lock",
                "package-lock.json",
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            }
        }
    }

    harpoon:setup()

    -- Loading Telescope extensions
    -- telescope.load_extension('smart_history')
    telescope.load_extension('fzf')

    -- Setting up Keybindings for lua configured plugins
    vim.api.nvim_set_keymap("n", "<leader>eo", ":NvimTreeFocus<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<leader>ef", ":NvimTreeFindFile<CR>", { noremap = true })
    vim.api.nvim_set_keymap('n', '<C-p>', ":lua require'telescope.builtin'.find_files({find_command=rg})<CR>",
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>ff', ":Telescope live_grep find_command=rg<CR>",
        { noremap = true, silent = true })

    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
end


return M
