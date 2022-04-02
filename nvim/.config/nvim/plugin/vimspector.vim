let g:vimspector_sign_priority = {
  \    'vimspectorBP':         999,
  \    'vimspectorBPCond':     999,
  \    'vimspectorBPDisabled': 999,
  \    'vimspectorPC':         999,
  \ }

function s:DisableFolds()
  " Customise the terminal window size/position
  " For some reasons terminal buffers in Neovim have line numbers
  call win_gotoid( g:vimspector_session_windows.variables )
  set nofoldenable
  call win_gotoid( g:vimspector_session_windows.watches )
  set nofoldenable
  call win_gotoid( g:vimspector_session_windows.stack_trace )
  set nofoldenable
endfunction

augroup MyVimspectorUICustomistaion
  autocmd!
  autocmd User VimspectorUICreated call s:DisableFolds()
augroup END
