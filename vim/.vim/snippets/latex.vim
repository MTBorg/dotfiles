" Prints a specified command and its environment.
" Works by executing the parameters in a normal command.
"	
"	Examples:
"	Command("begin", "equation", 1)
"	---
"	\begin{equation}
" <INSERT>
"	\end{equation}
"
"	Command("subsubsection", "Chapter 4", 0)
"	---
"	\subsubsection{Chapter 4}
"	<INSERT>
"
" Parameters:
" @param cmd: The command to print
" @param env: The environment of the command
" @param close_cmd: Whether or not to close the command
"
" Remarks:
" Needs to be started from normal mode.
" 
function! Command(cmd, env, close_cmd) abort
	let norm = ":normal i\\".a:cmd."{"
	if len(a:env) != 0
		let norm = norm.a:env."}<+++>"
	else
		let norm = norm."<+++>}<+++>"
	endif
	if a:close_cmd
		let norm = norm."\\end{".a:env."}"
	endif
	" If an environment was given we only need to go back one step
	" , otherwise two.
	if len(a:env) != 0
		let norm = norm."?<+++>df>"
	else
		let norm = norm."?<+++>ndf>"
	endif
	exe norm
	exe ":startinsert"
endfunction

" Math
nnoremap <Leader>m i$$<Esc>i
" Equations
nnoremap <Leader>eq :call Command("begin", "equation", 1)<CR>
nnoremap <Leader>*eq :call Command("begin", "equation*", 1)<CR>
inoremap <Leader>eq <Esc>:call Command("begin", "equation", 1)<CR>
inoremap <Leader>*eq <Esc>:call Command("begin", "equation*", 1)<CR>
" Sections
nnoremap <Leader>s :call Command("section", "", 0)<CR>
nnoremap <Leader>ss :call Command("subsubsection", "", 0)<CR>
inoremap <Leader>s  <Esc>:call Command("section", "", 0)<CR>
inoremap <Leader>ss <Esc>:call Command("subsubsection", "", 0)<CR>
" Fractions
nnoremap <Leader>f i\frac{<+++>}{<+++>}<Esc>?<+++><CR>ncf>
inoremap <Leader>f <Esc>i\frac{<+++>}{<+++>}<Esc>?<+++><CR>ncf>
