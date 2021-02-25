" coc-snippets
""""""""""""""""""""""
let g:coc_snippet_next = '<c-l>'
let g:coc_snippet_prev = '<c-h>'
let g:coc_global_extensions = [
			\ 'coc-tsserver',
			\ 'coc-python',
			\ 'coc-json',
			\ 'coc-eslint',
			\ 'coc-prettier',
			\ 'coc-css',
			\ 'coc-html',
			\ 'coc-snippets',
			\ 'coc-yaml',
			\ 'coc-vimlsp',
			\ 'coc-go',
			\ 'coc-sh',
			\ 'coc-docker',
			\ 'coc-rls'
			\]

" Trigger completion when pressing enter in the popup menu
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use `gn` and `gp` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gp <Plug>(coc-diagnostic-prev)
"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
