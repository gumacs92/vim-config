let map = "\\"

nnoremap <leader><leader><CR> :source $MYVIMRC<CR> | :echom 'Sourced file'
nnoremap <leader>v<CR> :e $MYVIMRC<CR>
nnoremap <leader>bb :Bdelete<CR>
nnoremap <leader>ab :bufdo :Bdelete<CR>

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
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" nnoremap <silent> <leader>f :Format<CR>
nnoremap <silent> <leader>F :FormatWrite<CR>

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>F

" nnoremap <silent> <C-p> :Files<CR>
" nnoremap <silent> <C-f> :Ag<Cr>

" Vim Script
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
"

echom "Sourced vim/mappings.vim"
