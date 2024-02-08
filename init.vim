echo 'Created init.vim successfully!'

let path = expand('<sfile>:p:h')
exec 'source' path . '/vim/mappings.vim'

set ignorecase
set hlsearch
set showmatch

call plug#begin('~/.config/nvim/plugged')
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
" buffer related
Plug 'moll/vim-bbye'
Plug 'ojroques/nvim-bufdel'
Plug 'nvim-lua/plenary.nvim' " dependency for telescope
Plug 'kkharji/sqlite.lua'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-project.nvim'
Plug 'nvim-telescope/telescope-smart-history.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'kevinhwang91/nvim-bqf', {'do': ':BqfEnable'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'neovim/nvim-lspconfig' "  Collection of configurations for built-in LSP client
Plug 'hrsh7th/nvim-cmp' "  Autocompletion plugin
Plug 'hrsh7th/cmp-nvim-lsp' "  LSP source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip' "  Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' "  Snippets plugin
Plug 'https://gitlab.com/yorickpeterse/nvim-pqf'
Plug 'https://github.com/stefandtw/quickfix-reflector.vim'
Plug 'olivercederborg/poimandres.nvim'
Plug 'altercation/vim-colors-solarized'
Plug 'github/copilot.vim'
Plug 'aserowy/tmux.nvim'
Plug 'nvim-tree/nvim-tree.lua'
call plug#end()

function SourceLua() abort
lua << EOF
package.loaded['init'] = nil
require('init')
EOF
endfunction

call SourceLua()

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
" autocmd BufReadPost,FileReadPost * normal zR

set clipboard=unnamedplus
hi ActiveWindow guibg=#21242b
hi InactiveWindow guibg=#282C34
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

" TODO replace magent with somtehing more styliest
highlight Sneak guifg=black guibg=red ctermfg=black ctermbg=red
highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

" bqf highlight
" hi default link BqfPreviewFloat Normal
" hi default link BqfPreviewBorder FloatBorder
" hi default link BqfPreviewTitle Title
" hi default link BqfPreviewThumb Thumb
" hi default link BqfPreviewCursor Cursor
" hi default link BqfPreviewRange IncSearch

au TextYankPost * silent! lua vim.highlight.on_yank()
" format on save
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END

autocmd DirChanged * silent! Prosession


let g:copilot_no_tab_map = v:true

command! -bang -nargs=? -complete=dir Files
            \ call fzf#vim#files(<q-args>, {'oions': ['--layout=reverse', '--info=inline', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

runtime macros/sandwich/keymap/surround.vim

" set autoindent
set smartindent
filetype plugin indent on " auto indentation based on filetype

" hi CursorLine   cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white
" set cursorline
" hi CursorColumn cterm=NONE ctermbg=gray ctermfg=white guibg=gray guifg=white
" set cursorcolumn
