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
set foldlevel=0
set foldmethod=indent
set noshowmode "Don't show mode as this is shown by the lightline plugin
filetype plugin indent on
syntax on

nnoremap <SPACE> nop
let mapleader=" "

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

	" Language packs
	" Use rust.vim directly, rather than from polyglot.
	" polyglot_disabled should be defined here as it has to be set before
	" polyglot is loaded.
	let g:polyglot_disabled=['rust'] 
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }
	Plug 'sheerun/vim-polyglot'

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
	Plug 'mattn/emmet-vim'
	Plug 'LucHermitte/local_vimrc'
	Plug 'LucHermitte/lh-vim-lib'
	Plug 'jiangmiao/auto-pairs'
	Plug 'styled-components/vim-styled-components'
	Plug 'wellle/context.vim'
	Plug 'puremourning/vimspector'

	" Harpooon
	Plug 'nvim-lua/plenary.nvim' 
	Plug 'ThePrimeagen/harpoon'

	Plug 'itchyny/lightline.vim'
	Plug 'josa42/vim-lightline-coc'
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
autocmd BufEnter *.pa set filetype=conf

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

function Upgrade() 
	:PlugUpgrade
	:PlugUpdate
	:CocUpdate
endfunction
command Upgrade :call Upgrade()

" Static colorscheme
" colorscheme gotham

" Pywal colorscheme
colorscheme wal
set notermguicolors
set background=light
