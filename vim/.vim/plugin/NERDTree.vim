" Show hidden files
let g:NERDTreeShowHidden=1
" Don't auto center
let g:NERDTreeAutoCenter=0
" Don't sort dot-files/directories first
let g:NERDTreeSortHiddenFirst=0
" Quit after opening a file
let g:NERDTreeQuitOnOpen=1
" Show line number
let g:NERDTreeShowLineNumbers=1

" Exit vim if nerdtree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
