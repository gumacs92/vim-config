echo 'Created init.vim successfully!'

" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-commentary'
	" Plug 'williamboman/mason.nvim'
	Plug 'moll/vim-bbye'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
	Plug 'nvim-telescope/telescope-project.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'nvim-telescope/telescope-file-browser.nvim'
	Plug 'nvim-tree/nvim-web-devicons'
	Plug 'rmagatti/auto-session'
	Plug 'rmagatti/session-lens'
call plug#end()

let path = expand('<sfile>:p:h')
exec 'source' path . '/vim/mappings.vim' 

lua require('init')

" augroup filetype_vim
"     autocmd!
"     autocmd FileType vim setlocal foldmethod=marker
" augroup END

" set clipboard+=unnamedplus
set incsearch
set ignorecase
set hlsearch
set showmatch

if exists('g:vscode')
    " VSCode extension
else
	set relativenumber
	set number
	" set syntax=on
	set shiftwidth=4 | " Set shift width to 4 spaces.
	set tabstop=4 | " Set tab width to 4 columns
	set mouse=a
	set encoding=UTF-8

	command! -bang -nargs=? -complete=dir Files
				\ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

	
	" hi CursorLine   cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white
	" set cursorline
	" hi CursorColumn cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white
	" set cursorcolumn
endif
