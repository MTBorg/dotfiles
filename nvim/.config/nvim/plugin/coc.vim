" coc-snippets
""""""""""""""""""""""
let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd FileType python let b:coc_root_patterns = ['.git', '.env']
