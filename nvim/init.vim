" default settings for VIM {{{
if !has('nvim')
  " load defaults.vim
  unlet! skip_defaults_vim
  source $VIMRUNTIME/defaults.vim

  " :help vim-differences
  set autoindent
  set autoread
  set belloff=all
  set nocompatible
  set comments+=fb:•
  set commentstring=
  set complete-=i
  set define=^\\s*#\\s*define
  set display=lastline
  set fillchars=vert:│,fold:·,foldsep:│
  set formatoptions=tcqj
  set hidden
  set history=10000
  set hlsearch
  set include=
  set incsearch
  set nojoinspaces
  set langnoremap
  set nolangremap
  set laststatus=2
  set mouse=nvi
  set mousemodel=popup_setpos
  set nrformats=bin,hex
  set ruler
  set sessionoptions+=unix,slash
  set sessionoptions-=options
  set shortmess+=CF
  set shortmess-=S
  set showcmd
  set sidescroll=1
  set smarttab
  set nostartofline
  set switchbuf=uselast
  set tabpagemax=50
  set tags=./tags;,tags
  set ttimeoutlen=50
  set ttyfast
  set viewoptions+=unix,slash
  set viewoptions-=options
  set viminfo+=!
  set wildoptions=pum,tagfile
endif
" }}}

let g:mapleader = "\<space>"

" Disable providers to improve startup time.
for s:p in ['node', 'perl', 'python3', 'ruby']
  execute 'let g:loaded_' . s:p . '_provider = 0'
endfor

" plugins {{{
let s:url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
let s:data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(s:data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo ' . s:data_dir . '/autoload/plug.vim --create-dirs ' . s:url
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
\ | PlugInstall --sync | source $MYVIMRC
\ | endif

call plug#begin()
" editor scheme
Plug 'Luxed/ayu-vim'
Plug 'itchyny/lightline.vim'

" language support
Plug 'dart-lang/dart-vim-plugin'
Plug 'hashivim/vim-terraform'
if !has('nvim')
  Plug 'Vimjas/vim-python-pep8-indent'
endif

" editor enhancement
Plug 'airblade/vim-gitgutter'
Plug 'cohama/lexima.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
if has('nvim')
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
endif
if has('patch-9.0.1799')
  packadd! editorconfig
elseif !has('nvim-0.9')
  Plug 'editorconfig/editorconfig-vim'
endif

" language server and completion
if has('nvim-0.5')
  Plug 'neovim/nvim-lspconfig'
    Plug 'ray-x/lsp_signature.nvim'
  Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-path'
    if !has('nvim-0.10')
      Plug 'hrsh7th/cmp-vsnip'
    endif
else
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-buffer.vim'
    Plug 'prabirshrestha/asyncomplete-file.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
endif
if !has('nvim-0.10')
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
endif

call plug#end()
" }}}

" Editor Settings {{{
filetype plugin indent on
syntax on

set noswapfile
set nobackup

" utf-8 as default
set fileencodings=ucs-bom,utf-8,default,cp932
" use `<LF>` for line ending
set fileformats=unix,dos

" general
set colorcolumn=80,100,120
set cursorline
set foldmethod=marker
set noshowmode
set number
set nrformats+=unsigned
set scrolloff=3
set showmatch
set showtabline=2
set splitbelow
set splitright
set updatetime=100

" clipboard
set clipboard=unnamedplus

" invisible characters
set list
set listchars=tab:>\ ,space:∙

" completion
set shortmess+=c
set completeopt=menu,menuone,noselect

" indent
set expandtab     " use spaces instead of tabs
set shiftwidth=2  " indent width is 2
set softtabstop=2 " 2-space when <Tab> is pressed

" search
set ignorecase " case-insensitive search when all characters is small
set smartcase  " case-sensitive when capitals are used
if has('nvim')
  set inccommand=split
endif

" LaTeX
let g:tex_flavor = 'latex'

" color scheme
set termguicolors " use 24-bit true color
set background=dark
let g:ayucolor = 'dark'
colorscheme ayu
if !has('nvim')
  hi SpecialKey guifg=#464b56
endif
" }}}

" Keymaps {{{
if !has('nvim')
  nnoremap Y y$
  nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>
  inoremap <C-U> <C-G>u<C-U>
  inoremap <C-W> <C-G>u<C-W>
  xnoremap * y/\V<C-R>"<CR>
  xnoremap # y?\V<C-R>"<CR>
  nnoremap & :&&<CR>
endif

nnoremap j gj
vnoremap j gj
nnoremap k gk
vnoremap k gk

tnoremap <Esc> <C-\><C-n>

" emacs like keybinding for command-line mode
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
" }}}

" autocmd {{{
augroup FiletypeIndent
  autocmd!
  autocmd FileType python setl sts=4 sw=4
  autocmd FileType go,make,sh,zsh setl noet sts& sw&
augroup END

augroup FiletypeComment
  autocmd!
  " prefer line comments for C and C++
  autocmd FileType c,cpp setl cms=//%s
augroup END

if has('nvim')
  augroup NeovimTerminal
    autocmd!
    " disable line numbers in terminal
    autocmd TermOpen * setl nonu nornu
    " allow to use Ctrl-C to send SIGINT in normal mode
    autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
  augroup END
else
  augroup VimTerminal
    autocmd!
    " disable line numbers in terminal
    autocmd TerminalOpen * setl nonu nornu
    " allow to use Ctrl-C to send SIGINT in normal mode
    autocmd TerminalOpen * nnoremap <buffer> <C-c> i<C-c>
  augroup END
endif
" }}}

" command {{{
command TrimTrailingSpace :%s/\s\+$//ge
" }}}
