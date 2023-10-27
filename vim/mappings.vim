let map = "\\"

nnoremap <leader><leader><CR> :source $MYVIMRC<CR> | :call SourceLua() | :echom 'Sourced file'
nnoremap <leader>v<CR> :e $MYVIMRC<CR>
nnoremap <leader>q :BufDel!<CR>
nnoremap <leader>cq :BufDelOther!<CR>
nnoremap <leader>aq :BufDelAll!<CR>

inoremap jk <ESC>
" inoremap <ESC> <NOP>

nnoremap o o<esc><S-v>=
nnoremap O O<esc><S-v>=

nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

vnoremap <Del> c
vnoremap <Bs> c

" nnoremap <C-P> :FZF<CR>
nnoremap <c-j> 30<c-w>j
nnoremap <c-k> 30<c-w>k
nnoremap <c-h> 30<c-w>h
nnoremap <c-l> 30<c-w>l

" nnoremap <silent> <leader>f :Format<CR>
nnoremap <silent> <leader>F :FormatWrite<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>F

" nnoremap <silent> <C-p> :Files<CR>
" nnoremap <silent> <C-f> :Ag<Cr>

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
"

echom "Sourced vim/mappings.vim"
