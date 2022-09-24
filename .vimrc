set termencoding=utf-8
set encoding=utf-8
set nocompatible
set mouse=r
set noswapfile
set nobackup
set history=1000
set undolevels=1000
set autoread
au FocusGained,BufEnter * :checktime

set title
syntax on
set showcmd
set showmode
set number
set ruler
set showmatch
set linebreak
set nowrap
set whichwrap=b,s,<,>,[,]
set backspace=indent,eol,start

filetype indent on
set autoindent
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

set hlsearch
set incsearch
set ignorecase
set smartcase

colorscheme iceberg
set background=light

let NERDTreeNaturalSort=1
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[]
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1

map <F2>      :NERDTreeToggle<CR>
map <C-t>     :tabnew<CR>
map <C-Right> :tabnext<CR>
map <C-Left>  :tabprevious<CR>
map <C-p>     :FZF<CR>
