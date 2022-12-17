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


" augroup filetype_vim
"     autocmd!
"     autocmd FileType vim setlocal foldmethod=marker
" augroup END


lua << EOF
require('auto-session').setup({
	auto_session_enabled = true,
	auto_session_enable_last_session = true
})
require('telescope').setup {
	extensions = {
		project = {
			base_dirs = {
				'~/dev',
			},
			theme = "dropdown",
			order_by = "asc",
			sync_with_nvim_tree = true, -- default false
		}
	}
}
require'telescope'.load_extension('project')
require("telescope").load_extension "file_browser"
require("telescope").load_extension("session-lens")
vim.api.nvim_set_keymap(
  "n",
  "<leader>e",
  ":Telescope file_browser<CR>",
  { noremap = true }
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>p',
	":lua require'telescope'.extensions.project.project{}<CR>",
	{noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>s',
	":lua require('session-lens').search_session()<CR>",
	{noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
	'n',
	'<C-p>',
	":Telescope find_files<CR>",
	{noremap = true, silent = true}
)
EOF

" set clipboard+=unnamedplus
set incsearch
set ignorecase
set hlsearch
set showmatch

let map = "\\"

nnoremap <leader><leader><CR> :source $MYVIMRC<CR> | :echom 'Sourced vim.rc'
nnoremap <leader>v<CR> :e $MYVIMRC<CR>
nnoremap <leader>q :Bdelete<CR>
nnoremap <leader>qa :bufdo :Bdelete<CR>

inoremap jk <C-C>
" inoremap <ESC> <NOP>

nnoremap o o<esc>
nnoremap O O<esc>

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

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

	" nnoremap <C-P> :FZF<CR>

	nnoremap <c-j> <c-w>j
	nnoremap <c-k> <c-w>k
	nnoremap <c-h> <c-w>h
	nnoremap <c-l> <c-w>l

	nnoremap <silent> <C-Space> :call fzf#run(fzf#wrap({'source': 'find $HOME/dev -maxdepth 2 -type d', 'sink': 'e'}))<CR>
	command! -bang -nargs=? -complete=dir Files
				\ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)
	" ind files using Telescope command-line sugar.
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>F

	" nnoremap <silent> <C-p> :Files<CR> 
	" nnoremap <silent> <C-f> :Ag<Cr>	
	" hi CursorLine   cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white
	" set cursorline
	" hi CursorColumn cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white
	" set cursorcolumn
endif
