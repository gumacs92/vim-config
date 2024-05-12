return {
    'tpope/vim-abolish',
    'tpope/vim-sensible',
    'tpope/vim-repeat',
    {
        'dhruvasagar/vim-prosession',
        dependencies = { 'tpope/vim-obsession' }
    },
    'JoosepAlviste/nvim-ts-context-commentstring',
    'numToStr/Comment.nvim',
    'lukas-reineke/indent-blankline.nvim',
    'wellle/targets.vim',
    'machakann/vim-sandwich',
    'justinmk/vim-sneak',
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
    { 'nvim-treesitter/nvim-treesitter',          build = ':TSUpdate' },
    'tree-sitter-grammars/tree-sitter-markdown', -- tree-sitter grammar for markdown_inline for Lspsaga
    -- 'kevinhwang91/nvim-bqf', {'do': ':BqfEnable'}
    'nvim-lualine/lualine.nvim',
    'folke/which-key.nvim',
    'https://gitlab.com/yorickpeterse/nvim-pqf',
    'https://github.com/stefandtw/quickfix-reflector.vim',
    'olivercederborg/poimandres.nvim',
    'altercation/vim-colors-solarized',
    'atelierbram/vim-colors_atelier-schemes',
    'aserowy/tmux.nvim',


    -- oil and icon pack
    'nvim-tree/nvim-web-devicons',
    'stevearc/oil.nvim',
    'SirZenith/oil-vcs-status',

    -- mason and lsp related
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',    --  Collection of configurations for built-in LSP client
    'hrsh7th/nvim-cmp',         --  Autocompletion plugin
    'hrsh7th/cmp-nvim-lsp',     --  LSP source for nvim-cmp
    'saadparwaiz1/cmp_luasnip', --  Snippets source for nvim-cmp
    'L3MON4D3/LuaSnip',         --  Snippets plugin
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
