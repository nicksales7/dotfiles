" Use vim-plug as plugin manager
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"
let g:vimtex_view_method = 'zathura'

Plug 'aditya-azad/candle-grey'


call plug#end()

" General settings
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
colorscheme candle-grey-transparent

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

" Autoclose for TeX files
autocmd FileType tex inoremap \( \(\)<Left><Left>
autocmd FileType tex inoremap \[ \[\]<Left><Left>
autocmd FileType tex inoremap \{ \{\}<Left><Left>

" Spellcheck markdown
autocmd FileType markdown setlocal spell spelllang=en

" Autoclose brackets and quotes globally
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
