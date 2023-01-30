echo 'Created init.vim successfully!'

let path = expand('<sfile>:p:h')
exec 'source' path . '/vim/mappings.vim' 

set ignorecase
set hlsearch
set showmatch

if exists('g:vscode')
    " VSCode extension
	call plug#begin('~/.config/nvim/plugged')
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-abolish'
	call plug#end()
else
	call plug#begin('~/.config/nvim/plugged')
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-sensible'
	Plug 'moll/vim-bbye'
	Plug 'nvim-lua/plenary.nvim' " dependency for telescope
	Plug 'kkharji/sqlite.lua'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
	Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
	Plug 'nvim-telescope/telescope-project.nvim'
	Plug 'nvim-telescope/telescope-smart-history.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'nvim-lualine/lualine.nvim'
	Plug 'rmagatti/auto-session'
	Plug 'rmagatti/session-lens'
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'mhartington/formatter.nvim' 
	Plug 'neovim/nvim-lspconfig'
	Plug 'neovim/nvim-lspconfig' "  Collection of configurations for built-in LSP clien t
	Plug 'hrsh7th/nvim-cmp' "  Autocompletion plugin
	Plug 'hrsh7th/cmp-nvim-lsp' "  LSP source for nvim-cmp
	Plug 'saadparwaiz1/cmp_luasnip' "  Snippets source for nvim-cmp
	Plug 'L3MON4D3/LuaSnip' "  Snippets plugin
	Plug 'folke/trouble.nvim'
	Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' 
	Plug 'https://gitlab.com/yorickpeterse/nvim-pqf'
	Plug 'https://github.com/stefandtw/quickfix-reflector.vim'
	" Plug 'sainnhe/everforest'
    Plug 'Mofiqul/vscode.nvim'
	Plug 'altercation/vim-colors-solarized'	
	Plug 'github/copilot.vim'
	Plug 'aserowy/tmux.nvim'
	Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'
	Plug 'nvim-tree/nvim-tree.lua'
	call plug#end()

	lua require('init')

	set splitbelow
	set splitright
	set signcolumn=yes
	set relativenumber
	set number
	" set syntax=on
    set keymodel=startsel,stopsel    

    autocmd FileType * setlocal shiftwidth=4 tabstop=4 expandtab
    autocmd FileType typescript setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType typescriptreact setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType javascriptreact setlocal shiftwidth=2 tabstop=2 expandtab
    autocmd FileType vue setlocal shiftwidth=2 tabstop=2 expandtab

	set mouse=a
	set encoding=UTF-8


	" set foldmethod=expr
	" set foldexpr=nvim_treesitter#foldexpr()
	" set nofoldenable

	set background=dark
	" colorscheme everforest
	" hi ActiveWindow guibg=#21242b
	" hi InactiveWindow guibg=#282C34
	" set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

	au TextYankPost * silent! lua vim.highlight.on_yank()

	" let g:copilot_no_tab_map = v:true

	command! -bang -nargs=? -complete=dir Files
				\ call fzf#vim#files(<q-args>, {'oions': ['--layout=reverse', '--info=inline', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)


	" hi CursorLine   cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white
	" set cursorline
	" hi CursorColumn cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white
	" set cursorcolumn
endif
