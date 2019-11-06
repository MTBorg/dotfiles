setlocal noexpandtab
setlocal shiftwidth=2
setlocal tabstop=2

let b:pear_tree_pairs = {
            \ '(': {'closer': ')'},
           	\ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
            \ '<*>': {'closer': '</*>'},
            \ }

