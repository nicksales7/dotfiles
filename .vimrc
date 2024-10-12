" Use vim-plug as plugin manager
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

call plug#end()

" General settings
colorscheme habamax
set number                  " Show line numbers
set relativenumber          " Show relative line numbers
set cursorline              " Highlight current line
set mouse=a                 " Enable mouse support in all modes
set background=dark         " Dark mode
set clipboard=unnamedplus   " Enable clipboard support
set termguicolors           " Enable 24-bit RGB color
set cmdheight=2             " Set command-line height
set splitbelow              " Horizontal splits go below
set splitright              " Vertical splits go right
set updatetime=300          " Reduce update time for responsive UI

" Tab and indentation settings
set tabstop=4               " Tab width
set shiftwidth=4            " Indent width
set expandtab               " Convert tabs to spaces
set autoindent              " Auto-indent new lines
set smartindent             " Smarter indentation

" Line numbering and search settings
set hlsearch                " Highlight search results
set incsearch               " Incremental search
set ignorecase              " Ignore case when searching
set smartcase               " Smart case for searching

" Wildmenu settings
set wildmenu                " Enable wildmenu for command line completion

" Undofile settings
set noundofile              " Disable persistent undo

" Disable swap files
set noswapfile

" Backspace settings
set backspace=indent,eol,start

" Autoclose brackets and quotes
inoremap ( ()<Left>
inoremap ' ''<Left> 
inoremap ` ``<Left>
inoremap " ""<Left>
inoremap [ []<Left>
inoremap { {}<Left>

" Disable arrow keys 
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

noremap! <Up> <Nop>
noremap! <Down> <Nop>
noremap! <Left> <Nop>
noremap! <Right> <Nop>

" Set up autocmds for specific filetypes
autocmd FileType markdown setlocal spell spelllang=en
autocmd FileType markdown,tex nnoremap <buffer> <C-l> $$<Left>
autocmd FileType markdown,tex inoremap <buffer> <C-l> $$<Left>
