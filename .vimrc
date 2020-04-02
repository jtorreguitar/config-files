set nocompatible
syntax on
filetype plugin indent on
set number relativenumber
set encoding=utf-8
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" Enable folding
set foldmethod=indent
set foldlevel=99
let mapleader=" "

call plug#begin('~/.vim/plugged')
  Plug 'tmhedberg/SimpylFold'
  Plug 'vim-scripts/indentpython.vim'
  Plug 'nvie/vim-flake8'
  Plug 'kien/ctrlp.vim'
  Plug 'junegunn/goyo.vim'
call plug#end()

map <S-j> <c-e>
map <S-k> <c-y>

command G Goyo
command W w !sudo tee %
