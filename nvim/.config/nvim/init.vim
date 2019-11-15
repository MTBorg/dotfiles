set nocompatible
set showmatch
set hlsearch 
set tabstop=2
set softtabstop=2
set noexpandtab
set shiftwidth=2
set autoindent
set number relativenumber
set cc=80
set termguicolors "Enable true colors
filetype plugin indent on
syntax on

" NERDTree
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>

call plug#begin('~/.local/share/nvim/plugged/')
	Plug 'whatyouhide/vim-gotham' "Color scheme
	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'airblade/vim-gitgutter'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'edkolev/tmuxline.vim'
call plug#end()

colorscheme gotham
