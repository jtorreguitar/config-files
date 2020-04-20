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
let statusline=1

call plug#begin('~/.vim/plugged')
  Plug 'kien/ctrlp.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'vim-syntastic/syntastic'
  Plug 'tpope/vim-sensible'
  Plug 'fatih/vim-go'
  Plug 'Valloric/YouCompleteMe'
call plug#end()

" scroll with shift+j,k
map <S-j> <c-e>
map <S-k> <c-y>
map <leader>n :noh<ENTER>

" change splits more naturally
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

command G Goyo
command W w !sudo tee %

autocmd BufnewFile,BufRead *.go set tw=70
autocmd BufnewFile,BufRead *.go nnoremap <leader>r :GoRename<Space>

" syntastic settings
let g:syntastic_mode_map = { "mode": "passive",
                            \ "active_filetypes": ["go"],
                            \ "passive_filetypes": [] }

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" running this twice will make the errors disappear from the screen
" but still appear on next write
map <leader>st :windo SyntasticToggleMode<ENTER>:windo SyntasticToggleMode<ENTER><ENTER>

" go settings
" use goimports for formatting
let g:go_fmt_command = "goimports"

" turn highlighting on
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_doc_keywordprg_enabled = 0
let g:go_list_height = 3
let g:syntastic_loc_list_height = 3

let g:syntastic_go_checkers = ['go', 'golint', 'errcheck']

" Open go doc in vertical window, horizontal, or tab
au Filetype go nnoremap <leader>v :vsp <CR>:exe "GoDef" <CR>
au Filetype go nnoremap <leader>s :sp <CR>:exe "GoDef"<CR>
au Filetype go nnoremap <leader>t :tab split <CR>:exe "GoDef"<CR>
