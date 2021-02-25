nmap <Leader>dd :call vimspector#Launch()<CR>
nmap <Leader>de :call vimspector#Reset()<CR>
nmap <Leader>dc <Plug>VimspectorContinue
nmap <Leader>dbp <Plug>VimspectorToggleBreakpoint
nmap <Leader>dbcp <Plug>VimspectorToggleConditionalBreakpoint
nmap <Leader>dj <Plug>VimspectorStepOver
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dk <Plug>VimspectorStepOut

let g:vimspector_sign_priority = {
  \    'vimspectorBP':         999,
  \    'vimspectorBPCond':     999,
  \    'vimspectorBPDisabled': 999,
  \    'vimspectorPC':         999,
  \ }
