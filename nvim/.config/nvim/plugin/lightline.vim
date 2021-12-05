let g:lightline = {}

let g:lightline.colorscheme = 'wal'
let g:lightline.separator = { 'left': '', 'right':  ''}

let g:lightline.active = {}
let g:lightline.active['left'] = []
call add(g:lightline.active['left'], [ 'gitbranch', 'readonly', 'filename', 'modified' ])
call add(g:lightline.active['left'], [ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ])
call add(g:lightline.active['left'], [ 'coc_status' ])

let g:lightline.active['right'] = []
call add(g:lightline.active['right'], ['lineinfo'])

let g:lightline.component_function = {}
let g:lightline.component_function['readonly'] = 'LightLineReadonly'
let g:lightline.component_function['filename'] = 'LightLineFullPath'
let g:lightline.component_function['gitbranch'] = 'FugitiveHead'

function! LightLineFullPath() 
	return expand('%')
endfunction

function! LightLineReadonly()
  return &readonly ? '' : ''
endfunction

call lightline#coc#register()
