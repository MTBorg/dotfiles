" ALE
" highlight clear ALEError
" highlight clear ALEErrorLine
" highlight clear ALEErrorSign
" highlight ALEError cterm=underline
" " highlight ALEErrorSign ctermbg=124
" highlight ALEErrorSign ctermfg=124 cterm=underline
" highlight clear ALEWarning
" highlight clear ALEWarningLine
let g:ale_enabled = 1
let g:ale_warn_about_trailing_blank_lines = 1
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_python_auto_pipenv = 1
let g:ale_python_flake8_auto_pipenv = 1
let g:ale_lint_on_text_changed = "never"
let g:ale_lint_on_enter = "never"
let g:ale_lint_on_save = 1
let g:ale_lint_delay = 0
let g:ale_fix_on_save = 1
let g:ale_linters = { 
    \ 'python': ["flake8"],
    \ "javascript": ["eslint"],
		\ "typescript": ["tslint", "eslint"]
\}
let g:ale_fixers = {
	\ "typescript": ["prettier"],
	\ "rust": ["rustfmt"],
\}
