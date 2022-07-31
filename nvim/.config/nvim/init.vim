set nocompatible
set showmatch
set hlsearch 
set tabstop=2
set softtabstop=2
set noexpandtab
set shiftwidth=2
set autoindent
set number relativenumber
set cc=80
set termguicolors "Enable true colors
set updatetime=200 "This makes the git gutter update faster
set noswapfile
set numberwidth=1
set encoding=UTF-8
set splitbelow splitright
set foldlevel=0
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set noshowmode "Don't show mode as this is shown by the lightline plugin
set conceallevel=0
filetype plugin indent on

nnoremap <SPACE> nop
let mapleader=" "

" Keybindings
""""""""""""""""""""""""""
	" Resource .vimrc
	nnoremap <silent> <Leader>src :source ~/.config/nvim/init.vim<CR>
	
	" NERDTree
	nnoremap <silent> <Leader>e :NERDTreeToggle<CR>

	" WhichKey
	nnoremap <silent> <Leader>? :WhichKey '<Leader>'<CR>

	" Jump window
	nnoremap <silent> <Leader>j :jumps<CR>

	" Close all windows but current
	nnoremap <silent> <Leader>o :only<CR>

	" Undotree
	nnoremap <silent> <Leader>u :UndotreeToggle<CR>

	" fzf
	nnoremap <silent> <C-p> :GFiles<CR>

	" vim-test
	nmap <silent> t<C-n> :TestNearest<CR>
	nmap <silent> t<C-f> :TestFile<CR>
	nmap <silent> t<C-s> :TestSuite<CR>
	nmap <silent> t<C-l> :TestLast<CR>
	nmap <silent> t<C-g> :TestVisit<CR>

	" harpoon
	nnoremap <Leader>1 :lua require("harpoon.ui").nav_file(1)<CR>
	nnoremap <Leader>2 :lua require("harpoon.ui").nav_file(2)<CR>
	nnoremap <Leader>3 :lua require("harpoon.ui").nav_file(3)<CR>
	nnoremap <Leader>4 :lua require("harpoon.ui").nav_file(4)<CR>
	nnoremap <Leader>nn :lua require("harpoon.ui").toggle_quick_menu()<CR>
	nnoremap <Leader>na :lua require("harpoon.mark").add_file()<CR>

	" vim-fugitive
	nnoremap <silent> <Leader>gd :Gdiffsplit<CR>
	nnoremap <silent> <Leader>gs :Gstatus<CR>
	nnoremap <silent> <Leader>gh :diffget //2<CR>
	nnoremap <silent> <Leader>gl :diffget //3<CR>
	nnoremap <silent> <Leader>gb :Gblame<CR>

	" vim-tmux-runner
	nmap <leader>tc :VtrSendCommandToRunner<Space>
	nmap <leader>to :VtrOpenRunner
	nmap <leader>tk :VtrKillRunner
	nmap <leader>tf :VtrFocusRunner
	nmap <leader>tl :VtrSendLinesToRunner
	vmap <leader>tl :VtrSendLinesToRunner

	" vim-spector
	nmap <Leader>dd :call vimspector#Launch()<CR>
	nmap <Leader>de :call vimspector#Reset()<CR>
	nmap <Leader>dgc :call vimspector#RunToCursor()<CR>
	nmap <Leader>dc <Plug>VimspectorContinue
	nmap <Leader>dbp <Plug>VimspectorToggleBreakpoint
	nmap <Leader>dbcp <Plug>VimspectorToggleConditionalBreakpoint
	nmap <Leader>dj <Plug>VimspectorStepOver
	nmap <Leader>dl <Plug>VimspectorStepInto
	nmap <Leader>dk <Plug>VimspectorStepOut
	nmap <Leader>di <Plug>VimspectorBalloonEval

	" coc
	" Bind popup navigation to ctrl-j and ctrl-k
	inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "j"
	inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "k"
	inoremap <expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "<CR>"
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	nmap <silent> gf <Plug>(coc-rename)
	" Use `gn` and `gp` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
	nmap <silent> gn <Plug>(coc-diagnostic-next)
	nmap <silent> gp <Plug>(coc-diagnostic-prev)
	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()
	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>
""""""""""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged/')
	"NERDTree
	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle' }
	Plug 'Xuyuanp/nerdtree-git-plugin'

	"Git
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	"Tmux
	Plug 'edkolev/tmuxline.vim'
	Plug 'christoomey/vim-tmux-runner'
	Plug 'christoomey/vim-tmux-navigator'

	"Coc
	Plug 'neoclide/coc.nvim', {
		\ 'branch': 'release'
	\}
	Plug 'antoinemadec/coc-fzf'

	" Fzf
	Plug 'junegunn/fzf'
	Plug 'junegunn/fzf.vim'

	"Styling
	Plug 'ap/vim-css-color'
	Plug 'whatyouhide/vim-gotham' 
	Plug 'dylanaraps/wal.vim'
	Plug 'ryanoasis/vim-devicons'

	" Language packs
	Plug 'baskerville/vim-sxhkdrc'

	"Misc
	Plug 'janko/vim-test'
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-surround'
	Plug 'Yggdroot/indentline'
	Plug 'honza/vim-snippets'
	Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
	Plug 'mbbill/undotree'
	Plug 'LucHermitte/local_vimrc'
	Plug 'LucHermitte/lh-vim-lib'
	Plug 'jiangmiao/auto-pairs'
	Plug 'wellle/context.vim'
	Plug 'puremourning/vimspector'
	Plug 'danilamihailov/beacon.nvim'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" Harpooon
	Plug 'nvim-lua/plenary.nvim' 
	Plug 'ThePrimeagen/harpoon'

	Plug 'itchyny/lightline.vim'
	Plug 'josa42/vim-lightline-coc'
call plug#end()

" This is necessary to use tab in command mode key bindings
set wildcharm=<tab>

" Navigate command mode completion menu with vim bindings (ctrl-j and ctrl-k)
cnoremap <expr> <C-k> pumvisible() ? "<S-Tab>" : "<C-k>"
cnoremap <expr> <C-j> pumvisible() ? "<Tab>" : "<C-j>"

" Resource config when saved
augroup vimrchook
	au!
	autocmd bufwritepost $MYVIMRC source $MYVIMRC
augroup END

autocmd BufEnter *.ts set filetype=typescript
autocmd BufEnter *.tsx set filetype=typescriptreact
autocmd BufEnter *.pa set filetype=conf

function! ConflictsHighlight() abort
    syn region conflictStart start=/^<<<<<<< .*$/ end=/^\ze\(=======$\||||||||\)/
    syn region conflictMiddle start=/^||||||| .*$/ end=/^\ze=======$/
    syn region conflictEnd start=/^\(=======$\||||||| |\)/ end=/^>>>>>>> .*$/

    highlight conflictStart ctermbg=red ctermfg=black
    highlight conflictMiddle ctermbg=blue ctermfg=black
    highlight conflictEnd ctermbg=green cterm=bold ctermfg=black
endfunction

augroup ConflictColors
    autocmd!
    autocmd BufEnter * call ConflictsHighlight()
augroup END

function Upgrade() 
	:PlugUpgrade
	:PlugUpdate
	:CocUpdate
	:TSUpdate
endfunction
command Upgrade :call Upgrade()

" Static colorscheme
" colorscheme gotham

" Pywal colorscheme
colorscheme wal
set notermguicolors
set background=light

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction



lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		"bash",
		"c",
		"cmake",
		"cpp",
		"css",
		"dockerfile",
		"go",
		"gomod",
		"graphql",
		"hcl",
		"help",
		"html",
		"http",
		"javascript",
		"json",
		"json5",
		"make",
		"markdown",
		"proto",
		"python",
		"rasi",
		"rust",
		"toml",
		"typescript",
		"vim",
		"yaml",
	},
	auto_install = true,
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
  },
}
EOF
