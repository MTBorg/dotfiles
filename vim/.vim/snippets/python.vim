"Functions 
noremap <Leader>f odef <Esc>i<+++>(<+++>):<CR><Tab><+++><Esc>?<+++><CR>2ncf>

" Conditionals
nnoremap <Leader>if oif (<+++>):<CR><Tab><+++><Esc>?<+++><CR>ncf>
inoremap <Leader>if if (<+++>):<CR><Tab><+++><Esc>?<+++><CR>ncf>
nnoremap <Leader>elif oelif (<+++>):<CR><Tab><+++><Esc>?<+++><CR>ncf>
inoremap <Leader>elif elif (<+++>):<CR><Tab><+++><Esc>?<+++><CR>ncf>
nnoremap <Leader>else oelse:<CR><Tab><+++><Esc>?<+++><CR>ncf>
inoremap <Leader>else else:<CR><Tab><+++><Esc>?<+++><CR>ncf>

" Loops
nnoremap <Leader>for ofor <+++> in <+++>:<CR><Tab><+++><Esc>?<+++><CR>2ncf>
inoremap <Leader>for for <+++> in <+++>:<CR><Tab><+++><Esc>?<+++><CR>2ncf>

" Classes
nnoremap <Leader>class oclass <+++>:<CR><Tab><+++><Esc>?<+++><CR>2ncf>
inoremap <Leader>class class <+++>:<CR><Tab><+++><Esc>?<+++><CR>2ncf>
