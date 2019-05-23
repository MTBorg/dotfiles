set nocompatible
set autoindent
set cursorline
set colorcolumn=90
set foldenable
set foldmethod=syntax
set history=100
set hlsearch
set incsearch
set ignorecase
set laststatus=2
set nospell
set noerrorbells
set number relativenumber
set numberwidth=1
set tabstop=2
set showmatch
set timeoutlen=1000 ttimeoutlen=0 "This makes visual blocks fast
syntax on

let mapleader=" "

" Keybindings
nnoremap <silent> <Leader>e :Explore<CR>
nnoremap <silent> <Leader>l :ALELint<CR>

filetype plugin on

" Colors
colorscheme onedark

execute pathogen#infect() 
