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

let mapleader="§"

" NERDTree
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>

call plug#begin('~/.local/share/nvim/plugged/')
	"Color scheme
	Plug 'whatyouhide/vim-gotham' 

	"NERDTree
	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }
	Plug 'Xuyuanp/nerdtree-git-plugin'

	"Tim Pope plugins
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'

	"Airline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	"Tmux
	Plug 'edkolev/tmuxline.vim'
	Plug 'christoomey/vim-tmux-runner'
	Plug 'christoomey/vim-tmux-navigator'

	"Coc
	Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocInstall coc-tsserver coc-python coc-json'}

	"Misc
	Plug 'airblade/vim-gitgutter'
	Plug 'janko/vim-test'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'ap/vim-css-color'
call plug#end()

colorscheme gotham
