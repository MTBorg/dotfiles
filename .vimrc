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
noremap <silent> <Leader>e :Explore<CR>

filetype plugin on

" Colors
colorscheme monokai_pro

" ALE
highlight clear ALEError
highlight clear ALEErrorLine
" highlight ALEErrorSign ctermbg=124
highlight ALEErrorSign ctermfg=124
highlight clear ALEWarning
highlight clear ALEWarningLine
let g:ale_enabled = 1
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_python_auto_pipenv = 1
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_delay = 0
let g:ale_linters = { 
    \ 'python': ["flake8"],
    \ "javascript": ["eslint"]
    \}

execute pathogen#infect() 
