echo 'Created init.vim successfully!'

let path = expand('<sfile>:p:h')
exec 'source' path . '/vim/mappings.vim' 

set incsearch
set ignorecase
set hlsearch
set showmatch

if exists('g:vscode')
    " VSCode extension
	call plug#begin('~/.config/nvim/plugged')
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	call plug#end()
else
	call plug#begin('~/.config/nvim/plugged')
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'moll/vim-bbye'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
	Plug 'nvim-telescope/telescope-project.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-telescope/telescope-file-browser.nvim'
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'rmagatti/auto-session'
	Plug 'rmagatti/session-lens'
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'neovim/nvim-lspconfig' "  Collection of configurations for built-in LSP client
	Plug 'hrsh7th/nvim-cmp' "  Autocompletion plugin
	Plug 'hrsh7th/cmp-nvim-lsp' "  LSP source for nvim-cmp
	Plug 'saadparwaiz1/cmp_luasnip' "  Snippets source for nvim-cmp
	Plug 'L3MON4D3/LuaSnip' "  Snippets plugin
	" Plug 'kyazdani42/nvim-web-devicons'
	Plug 'folke/trouble.nvim'
	Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' 
	Plug 'https://gitlab.com/yorickpeterse/nvim-pqf'
	Plug 'https://github.com/stefandtw/quickfix-reflector.vim'
	Plug 'tpope/vim-abolish'
	call plug#end()

	lua require('init')
	" filetype plugin on
	" set omnifunc=syntaxcomplete#Complete

	set signcolumn=number
	set relativenumber
	set number
	" set syntax=on
	set shiftwidth=4 | " Set shift width to 4 spaces.
	set tabstop=4 | " Set tab width to 4 columns
	set mouse=a
	set encoding=UTF-8

	command! -bang -nargs=? -complete=dir Files
				\ call fzf#vim#files(<q-args>, {'oions': ['--layout=reverse', '--info=inline', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)


	" hi CursorLine   cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white
	" set cursorline
	" hi CursorColumn cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white
	" set cursorcolumn
endif
