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
	" nnoremap <C-P> :FZF<CR>
	nnoremap <c-j> <c-w>j
	nnoremap <c-k> <c-w>k
	nnoremap <c-h> <c-w>h
	nnoremap <c-l> <c-w>l

	nnoremap <silent> <C-Space> :call fzf#run(fzf#wrap({'source': 'find $HOME/dev -maxdepth 2 -type d', 'sink': 'e'}))<CR>

	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>F

	" nnoremap <silent> <C-p> :Files<CR> 
	" nnoremap <silent> <C-f> :Ag<Cr>	
endif

echom "Sourced vim/mappings.vim"
