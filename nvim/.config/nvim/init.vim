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
set splitbelow splitright
filetype plugin indent on
syntax on

let mapleader="§"

" Keybindings
""""""""""""""""""""""""""
	" Resource .vimrc
	nnoremap <silent> <Leader>src :source ~/.config/nvim/init.vim<CR>
	
	" NERDTree
	nnoremap <silent> <Leader>e :NERDTreeToggle<CR>

	" WhichKey
	nnoremap <silent> <Leader>? :WhichKey '§'<CR>

	" Vim-fugitive
	nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
	nnoremap <silent> <Leader>gst :Gstatus<CR>
	nnoremap <silent> <Leader>gb :Gblame<CR>

	" Bind popup navigation to ctrl-j and ctrl-k
	inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("j"))
	inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("k"))

	" Jump window
	nnoremap <silent> <Leader>j :jumps<CR>

	" Undotree
	nnoremap <silent> <Leader>u :UndotreeToggle<CR>
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
		\ 'do': { -> #coc#util#install() }
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
	Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
	Plug 'mbbill/undotree'
	Plug 'mileszs/ack.vim'
	Plug 'sheerun/vim-polyglot'
	Plug 'mattn/emmet-vim'
	Plug 'ryanoasis/vim-devicons'
	Plug 'LucHermitte/local_vimrc'
	Plug 'LucHermitte/lh-vim-lib'
	Plug 'jiangmiao/auto-pairs'
	Plug 'dylanaraps/wal.vim'
call plug#end()

" This is necessary to use tab in command mode key bindings
set wildcharm=<tab>

" Navigate command mode completion menu with vim bindings (ctrl-j and ctrl-k)
cnoremap <expr> <C-k> pumvisible() ? "<S-Tab>" : "<C-k>"
cnoremap <expr> <C-j> pumvisible() ? "<Tab>" : "<C-j>"

" Resource config when saved
augroup vimrchook
	au!
	autocmd bufwritepost $MYVIMRC source $MYVIMRC
augroup END

autocmd BufEnter *.ts set filetype=typescript
autocmd BufEnter *.tsx set filetype=typescriptreact

" Static colorscheme
" colorscheme gotham

" Pywal colorscheme
colorscheme wal
set notermguicolors
set background=light
