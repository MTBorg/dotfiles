set omnifunc=syntaxcomplete#Complete
set completeopt+=menuone,noselect,noinsert
set nocompatible
set autoindent
" set cursorline " This is nice but makes vim slow in some case
set synmaxcol=90 " Limit syntax highlighting to amount of columns (you might want to disable this if you're on a fast system
set colorcolumn=90
set nofoldenable
set foldmethod=syntax
set history=100
set hlsearch
set incsearch
set ignorecase
set laststatus=2
set nospell
set noerrorbells
set noswapfile
set number relativenumber
set numberwidth=1
set tabstop=2
set showmatch
set shiftwidth=2
set timeoutlen=1000 ttimeoutlen=0 "This makes visual blocks fast
set updatetime=100
set viminfo+=n~/.vim/.viminfo "Different folder for viminfo file (disable if not on linux)

let mapleader="§"
" Latex support
let g:tex_flavor="latex"

" Keybindings
"""""""""""""""""""""""""""""""
" Resource .vimrc
nnoremap <silent> <Leader>up :source ~/.vimrc<CR>

" NERDTree
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>

" ALE
nnoremap <silent> <Leader>al :ALELint<CR>
nnoremap <silent> <Leader>af :ALEFix<CR>

" Next marker
nnoremap <silent> <Leader>n /<+++><CR>cf>
inoremap <silent> <Leader>n <Esc>/<+++><CR>cf>
" Previous marker
nnoremap <silent> <Leader>N ?<+++><CR>cf>
inoremap <silent> <Leader>N <Esc>?<+++><CR>cf>
" Place marker
inoremap <silent> <Leader>m <+++>
nnoremap <silent> <Leader>m i<+++>
" Used to finish tab completion when enter is pressed
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Bind popup navigation to ctrl-j and ctrl-k
inoremap <expr> <C-j> ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> <C-k> ((pumvisible())?("\<C-p>"):("k"))
" Cancel search
nnoremap <CR> :noh<CR><CR>
" Tags
nnoremap <Leader>tp :ptag<CR>
nnoremap <Leader>tc :pclose<CR>
"""""""""""""""""""""""""""""
"
" Colors
colorscheme onedark

call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }
Plug 'vim-scripts/AutoComplPop'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'wincent/terminus'
Plug 'mattn/emmet-vim'
Plug 'rust-lang/rust.vim'
Plug 'janko/vim-test'
Plug 'christoomey/vim-tmux-runner'
Plug 'qnighy/lalrpop.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-repeat'

call plug#end()

command! Conf :sp ~/.vimrc

autocmd BufEnter * syntax on
autocmd BufEnter *.tsx set filetype=typescript.vim
filetype plugin on
