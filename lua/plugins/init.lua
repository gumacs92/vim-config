return {
    'tpope/vim-abolish',
    'tpope/vim-repeat',
    'tpope/vim-sensible',
    {
        'dhruvasagar/vim-prosession',
        dependencies = { 'tpope/vim-obsession' }
    },
    'JoosepAlviste/nvim-ts-context-commentstring',
    'numToStr/Comment.nvim',
    'andymass/vim-matchup',
    'wellle/targets.vim',
    'machakann/vim-sandwich',
    'Wansmer/sibling-swap.nvim',
    -- 'justinmk/vim-sneak',
    { 'echasnovski/mini.jump',                    version = '*' },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "o", "x" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "o" },      function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    'windwp/nvim-ts-autotag',
    'windwp/nvim-autopairs',


    -- folding plugins
    {
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' }
    },
    -- {
    --     "chrisgrieser/nvim-origami",
    --     event = "BufReadPost", -- later or on keypress would prevent saving folds
    --     opts = true,           -- needed even when using default config
    -- },


    -- 'gcmt/wildfire.vim'
    'norcalli/nvim-colorizer.lua',
    -- buffer related
    'moll/vim-bbye',
    'ojroques/nvim-bufdel',
    'kkharji/sqlite.lua',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    'nvim-telescope/telescope-project.nvim',
    'nvim-telescope/telescope-smart-history.nvim',
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    'tree-sitter-grammars/tree-sitter-markdown', -- tree-sitter grammar for markdown_inline for Lspsaga
    'nvim-lualine/lualine.nvim',
    'folke/which-key.nvim',
    {
        'stevearc/quicker.nvim',
        event = "FileType qf",
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {
            edit = {
                -- Enable editing the quickfix like a normal buffer
                enabled = true,
            },
            highlight = {
                -- Use treesitter highlighting
                treesitter = true,
                -- Use LSP semantic token highlighting
                lsp = true,
                -- Load the referenced buffers to apply more accurate highlights (may be slow)
                load_buffers = true,
            },
            keys = {
                {
                    ">",
                    function()
                        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = "Expand quickfix context",
                },
                {
                    "<",
                    function()
                        require("quicker").collapse()
                    end,
                    desc = "Collapse quickfix context",
                },
            },
        },
    },
    'olivercederborg/poimandres.nvim',
    'altercation/vim-colors-solarized',
    'atelierbram/vim-colors_atelier-schemes',
    -- 'aserowy/tmux.nvim',


    -- oil and icon pack
    'nvim-tree/nvim-web-devicons',
    'stevearc/oil.nvim',
    'SirZenith/oil-vcs-status',

    -- mason and lsp and completion
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig', --  Collection of configurations for built-in LSP client
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "MattiasMTS/cmp-dbee",
                dependencies = {
                    { "kndndrj/nvim-dbee" }
                },
                ft = "sql", -- optional but good to have
                opts = {},  -- needed
            },
        },
    },
    'hrsh7th/cmp-nvim-lsp', --  LSP source for nvim-cmp
    'onsails/lspkind.nvim', --  Better icons for LSP completion items


    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip/loaders/from_vscode").load()
        end
    },                          --  Snippets plugin
    'saadparwaiz1/cmp_luasnip', --  Snippets source for nvim-cmp
    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({})
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        }
    },

    -- git related
    'tpope/vim-fugitive',
    'lewis6991/gitsigns.nvim',
    { 'akinsho/git-conflict.nvim',       version = "*",      config = true },

    -- scrollbar
    'petertriho/nvim-scrollbar',

    -- copilot
    'github/copilot.vim',

    -- starterscree
    'echasnovski/mini.nvim',
    'echasnovski/mini.starter',

    -- nvim-dap and extension installs
    'nvim-neotest/nvim-nio',
    'mfussenegger/nvim-dap',
    'jay-babu/mason-nvim-dap.nvim',
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },

    --null-ls install and extensions
    -- 'nvimtools/none-ls.nvim',
    'jose-elias-alvarez/null-ls.nvim',
    'jose-elias-alvarez/nvim-lsp-ts-utils',
    'jay-babu/mason-null-ls.nvim',
    {
        "kndndrj/nvim-dbee",
        dependencies = {
            "MunifTanjim/nui.nvim",
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
        },
        build = function()
            -- Install tries to automatically detect the install method.
            -- if it fails, try calling it with one of these parameters:
            --    "curl", "wget", "bitsadmin", "go"
            require("dbee").install()
        end,
        config = function()
            require("dbee").setup({
                source = {
                    require("dbee.sources").FileSource:new(vim.fn.stdpath("state") .. "/dbee/persistence.json")
                },
            })
        end,
    },
    {
        "GeorgesAlkhouri/nvim-aider",
        cmd = {
            "AiderTerminalToggle", "AiderHealth",
        },
        keys = {
            { "<leader>a/", "<cmd>AiderTerminalToggle<cr>", desc = "Open Aider" },
            { "<leader>as", "<cmd>AiderTerminalSend<cr>",          desc = "Send to Aider",                  mode = { "n", "v" } },
            { "<leader>ac", "<cmd>AiderQuickSendCommand<cr>",      desc = "Send Command To Aider" },
            { "<leader>ab", "<cmd>AiderQuickSendBuffer<cr>",       desc = "Send Buffer To Aider" },
            { "<leader>a+", "<cmd>AiderQuickAddFile<cr>",          desc = "Add File to Aider" },
            { "<leader>a-", "<cmd>AiderQuickDropFile<cr>",         desc = "Drop File from Aider" },
            { "<leader>ar", "<cmd>AiderQuickReadOnlyFile<cr>",     desc = "Add File as Read-Only" },
            -- Example nvim-tree.lua integration if needed
            { "<leader>a+", "<cmd>AiderTreeAddFile<cr>",           desc = "Add File from Tree to Aider",    ft = "NvimTree" },
            { "<leader>a-", "<cmd>AiderTreeDropFile<cr>",          desc = "Drop File from Tree from Aider", ft = "NvimTree" },
        },
        dependencies = {
            "folke/snacks.nvim",
            --- The below dependencies are optional
            "catppuccin/nvim",
            "nvim-tree/nvim-tree.lua",
        },
        config = true,
        opts = {
            aider_cmd = "aider --model=o3-mini",
            win = {
                wo = { winbar = "Aider" },
                style = "nvim_aider",
                position = "right",
            },
        }
    }
}
