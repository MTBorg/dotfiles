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
	nnoremap <silent> <Leader>? :WhichKey '<Leader>'<CR>

	" Bind popup navigation to ctrl-j and ctrl-k
	inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("j"))
	inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("k"))

	" Jump window
	nnoremap <silent> <Leader>j :jumps<CR>

	" Close all windows but current
	nnoremap <silent> <Leader>o :only<CR>

	" Undotree
	nnoremap <silent> <Leader>u :UndotreeToggle<CR>
""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged/')
	"NERDTree
	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }
	Plug 'Xuyuanp/nerdtree-git-plugin'

	"Git
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'
	Plug 'rhysd/git-messenger.vim'

	"Airline
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'

	"Tmux
	Plug 'edkolev/tmuxline.vim'
	Plug 'christoomey/vim-tmux-runner'
	Plug 'christoomey/vim-tmux-navigator'

	"Coc
	Plug 'neoclide/coc.nvim', {
		\ 'branch': 'release'
	\}

	" Fzf
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'

	"Styling
	Plug 'ap/vim-css-color'
	Plug 'whatyouhide/vim-gotham' 
	Plug 'dylanaraps/wal.vim'
	Plug 'ryanoasis/vim-devicons'

	"Misc
	Plug 'janko/vim-test'
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
	Plug 'LucHermitte/local_vimrc'
	Plug 'LucHermitte/lh-vim-lib'
	Plug 'jiangmiao/auto-pairs'
	Plug 'styled-components/vim-styled-components'
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

function! ConflictsHighlight() abort
    syn region conflictStart start=/^<<<<<<< .*$/ end=/^\ze\(=======$\||||||||\)/
    syn region conflictMiddle start=/^||||||| .*$/ end=/^\ze=======$/
    syn region conflictEnd start=/^\(=======$\||||||| |\)/ end=/^>>>>>>> .*$/

    highlight conflictStart ctermbg=red ctermfg=black
    highlight conflictMiddle ctermbg=blue ctermfg=black
    highlight conflictEnd ctermbg=green cterm=bold ctermfg=black
endfunction

augroup ConflictColors
    autocmd!
    autocmd BufEnter * call ConflictsHighlight()
augroup END

" Static colorscheme
" colorscheme gotham

" Pywal colorscheme
colorscheme wal
set notermguicolors
set background=light
