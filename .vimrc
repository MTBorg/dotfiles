set nocompatible
set autoindent
set cursorline
set foldenable
set foldmethod=syntax
set hlsearch
set incsearch
set nospell
set number relativenumber
set numberwidth=1
set tabstop=2
syntax on

" Language specifics
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" Colors
highlight Folded ctermbg=81


" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme="lucius"
let g:airline#extensions#ale#enabled = 1

" ALE
highlight clear ALEError
highlight clear ALEErrorLine
highlight ALEErrorSign ctermbg=124
highlight ALEErrorSign ctermfg=48
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
