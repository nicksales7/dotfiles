call plug#begin()
Plug 'lervag/vimtex'
Plug 'nanotech/jellybeans.vim' 
call plug#end()
syntax on
highlight Comment ctermfg=green
colorscheme jellybeans
set background=dark
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set number
set relativenumber
set hlsearch
set ruler
set clipboard=unnamedplus
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
