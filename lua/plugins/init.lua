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
    'lukas-reineke/indent-blankline.nvim',
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
    -- 'kevinhwang91/nvim-bqf', {'do': ':BqfEnable'}
    'nvim-lualine/lualine.nvim',
    'folke/which-key.nvim',
    'https://gitlab.com/yorickpeterse/nvim-pqf',
    'https://github.com/stefandtw/quickfix-reflector.vim',
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
    'neovim/nvim-lspconfig',    --  Collection of configurations for built-in LSP client
    'hrsh7th/nvim-cmp',         --  Autocompletion plugin
    'hrsh7th/cmp-nvim-lsp',     --  LSP source for nvim-cmp
    'onsails/lspkind.nvim',      --  Better icons for LSP completion items

        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
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
    'rcarriga/nvim-dap-ui',

    --null-ls install and extensions
    'jose-elias-alvarez/null-ls.nvim',
    'jay-babu/mason-null-ls.nvim',
}
