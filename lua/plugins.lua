
local M = {}

M.setup = function () 
    local Plug = vim.fn['plug#']

    vim.call('plug#begin')

    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-sensible'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-obsession'
    Plug 'dhruvasagar/vim-prosession'
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'
    Plug 'numToStr/Comment.nvim'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'wellle/targets.vim'
    Plug 'machakann/vim-sandwich'
    Plug 'justinmk/vim-sneak'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'windwp/nvim-autopairs'
    -- buffer related
    Plug 'moll/vim-bbye'
    Plug 'ojroques/nvim-bufdel'
    Plug 'nvim-lua/plenary.nvim' -- dependency for telescope
    Plug 'kkharji/sqlite.lua'
    Plug ('nvim-telescope/telescope.nvim', { tag = '0.1.4' })
    Plug ('nvim-telescope/telescope-fzf-native.nvim', { ['do']= 'make' })
    Plug 'nvim-telescope/telescope-project.nvim'
    Plug 'nvim-telescope/telescope-smart-history.nvim'
    Plug ('nvim-treesitter/nvim-treesitter', {['do']= ':TSUpdate'})
    -- Plug 'kevinhwang91/nvim-bqf', {'do': ':BqfEnable'}
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'folke/which-key.nvim'
    Plug 'https://gitlab.com/yorickpeterse/nvim-pqf'
    Plug 'https://github.com/stefandtw/quickfix-reflector.vim'
    Plug 'olivercederborg/poimandres.nvim'
    Plug 'altercation/vim-colors-solarized'
    Plug 'aserowy/tmux.nvim'
    Plug 'nvim-tree/nvim-tree.lua'

    -- mason and lsp related
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig' --  Collection of configurations for built-in LSP client
    Plug 'hrsh7th/nvim-cmp' --  Autocompletion plugin
    Plug 'hrsh7th/cmp-nvim-lsp' --  LSP source for nvim-cmp
    Plug 'saadparwaiz1/cmp_luasnip' --  Snippets source for nvim-cmp
    Plug 'L3MON4D3/LuaSnip' --  Snippets plugin

    -- copilot
    Plug 'github/copilot.vim'

    -- starterscree
    Plug 'echasnovski/mini.nvim'
    Plug 'echasnovski/mini.starter'

    -- nvim-dap and extension installs
    Plug 'nvim-neotest/nvim-nio'
    Plug 'mfussenegger/nvim-dap'
    Plug 'jay-babu/mason-nvim-dap.nvim'
    Plug 'rcarriga/nvim-dap-ui'

    --null-ls install and extensions
    Plug 'jose-elias-alvarez/null-ls.nvim'
    Plug 'jay-babu/mason-null-ls.nvim'

    vim.call('plug#end')
end


return M
