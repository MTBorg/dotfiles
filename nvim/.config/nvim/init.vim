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
set updatetime=200 "This makes the git gutter update faster
set noswapfile
set numberwidth=1
set encoding=UTF-8
filetype plugin indent on
syntax on

let mapleader="§"

" Keybindings
""""""""""""""""""""""""""
	" Resource .vimrc
	nnoremap <silent> <Leader>up :source ~/.config/nvim/init.vim<CR>
	
	" NERDTree
	nnoremap <silent> <Leader>e :NERDTreeToggle<CR>

	" Bind popup navigation to ctrl-j and ctrl-k
	inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("j"))
	inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("k"))
""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged/')
	"Color scheme
	Plug 'whatyouhide/vim-gotham' 

	"NERDTree
	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }
	Plug 'Xuyuanp/nerdtree-git-plugin'

	"Git
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	"Airline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	"Tmux
	Plug 'edkolev/tmuxline.vim'
	Plug 'christoomey/vim-tmux-runner'
	Plug 'christoomey/vim-tmux-navigator'

	"Coc
	Plug 'neoclide/coc.nvim', {
		\ 'branch': 'release', 
		\ 'do': ':CocInstall coc-tsserver coc-python coc-json coc-eslint coc-prettier coc-css coc-html coc-snippets'
	\}

	"Misc
	Plug 'janko/vim-test'
	Plug 'ctrlpvim/ctrlp.vim'
	Plug 'ap/vim-css-color'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'Yggdroot/indentline'
	Plug 'honza/vim-snippets'
call plug#end()

" Resource config when saved
augroup vimrchook
	au!
	autocmd bufwritepost $MYVIMRC source $MYVIMRC
augroup END

" Identine lines plugin messes up quotes in json files, so disable it for json
autocmd filetype json :IndentLinesDisable

colorscheme gotham
