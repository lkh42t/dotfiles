"
" basic.rc.vim
"

filetype plugin indent on
syntax enable

set termguicolors

set encoding=utf-8
set fileencoding=utf-8

set noswapfile
set nobackup

" General
set number
set ruler
set showcmd
set laststatus=2
set scrolloff=3
set cursorline
set colorcolumn=80
set showmatch
set matchtime=1
set hidden
set splitright

" Indent
set tabstop=4
set softtabstop=0
set shiftwidth=0
set shiftround
set expandtab
set autoindent
"set smartindent

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
set inccommand=split

" Optional
set foldmethod=marker

autocmd BufWritePre * :%s/\s\+$//ge

augroup FileTypeIndent
    autocmd!
    autocmd FileType html setlocal tabstop=2
    autocmd FileType css setlocal tabstop=2
    autocmd FileType javascript setlocal tabstop=2
augroup END
