" plugs.rc.vim

call plug#begin('~/.cache/nvim-plugins')

Plug 'tomasiser/vim-code-dark'
Plug 'itchyny/lightline.vim'

Plug 'editorconfig/editorconfig-vim'

Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'cohama/lexima.vim'
Plug 'mattn/emmet-vim', { 'for': 'html' }

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

call plug#end()

source ~/.config/nvim/plugins/nerdtree.rc.vim
source ~/.config/nvim/plugins/nerdcommenter.rc.vim

source ~/.config/nvim/plugins/coc.rc.vim
