let g:lightline = { 
	\ 'colorscheme': 'wal', 
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
		\ 'right': [
			\ ['lineinfo']
		\ ],
	\ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
\ }
