let g:lightline = { 
	\ 'colorscheme': 'wal', 
	\ 'active': {
	\   'left': [ 
	\							[ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ],  
	\							[ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], 
  \							[ 'coc_status'  ]
	\						],
		\ 'right': [
			\ ['lineinfo']
		\ ],
	\ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead',
  \   'filename': 'FullPath'
  \ },
\ }

function! FullPath() 
	return expand('%')
endfunction

call lightline#coc#register()
