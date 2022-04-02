let test#strategy = "neovim"

" Used to more easily exit out of the termnial opened when running tests
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif
