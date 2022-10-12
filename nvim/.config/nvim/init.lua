vim.keymap.set("n", "<SPACE>", "", {noremap = true})
vim.g.mapleader = " "

vim.o.syntax = "off"

vim.o.compatible = false
vim.o.showmatch = true
vim.o.hlsearch  = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.expandtab = false
vim.o.shiftwidth = 2
vim.o.autoindent = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cc = 80
vim.o.termguicolors = true -- "Enable true colors
vim.o.updatetime = 200 -- "This makes the git gutter update faster
vim.o.swapfile = false
vim.o.numberwidth = 1
vim.o.encoding = "UTF-8"
vim.o.splitright = true
vim.o.foldlevel=0
vim.o.foldmethod="expr"
vim.o.foldexpr="nvim_treesitter#foldexpr()"
vim.o.showmode = false -- "Don't show mode as this is shown by the lightline plugin
vim.o.conceallevel = 0
-- This is necessary to use tab in command mode key bindings
vim.o.wildcharm = ('\t'):byte()

vim.fn["plug#begin"]("~/.local/share/nvim/plugged/")
	local Plug = vim.fn["plug#"]

	-- NERDTree
	Plug('scrooloose/nerdtree', { on = "NERDTreeToggle" })
	Plug('Xuyuanp/nerdtree-git-plugin')

	-- Git
	Plug('tpope/vim-fugitive')
	Plug('airblade/vim-gitgutter')

	-- Tmux
	Plug('edkolev/tmuxline.vim')
	Plug('christoomey/vim-tmux-runner')
	Plug('christoomey/vim-tmux-navigator')

	-- Coc
	Plug ('neoclide/coc.nvim', {
		 branch = 'release'
	})
	Plug('antoinemadec/coc-fzf')

	-- Fzf
	Plug('junegunn/fzf')
	Plug('junegunn/fzf.vim')

	-- nvim-dap
	Plug('mfussenegger/nvim-dap')
	Plug('leoluz/nvim-dap-go')
	Plug('rcarriga/nvim-dap-ui')
	Plug('theHamsta/nvim-dap-virtual-text')

	-- Styling
	Plug('ap/vim-css-color')
	Plug('whatyouhide/vim-gotham')
	Plug('dylanaraps/wal.vim')
	Plug('ryanoasis/vim-devicons')
	Plug('olimorris/onedarkpro.nvim')

	-- Language packs
	Plug('baskerville/vim-sxhkdrc')

	-- Misc
	Plug('janko/vim-test')
	Plug('tpope/vim-repeat')
	Plug('tpope/vim-commentary')
	Plug('tpope/vim-surround')
	Plug('Yggdroot/indentline')
	Plug('honza/vim-snippets')
	Plug('liuchengxu/vim-which-key', { on = {'WhichKey', 'WhichKey!'} })
	Plug('mbbill/undotree')
	Plug('LucHermitte/local_vimrc')
	Plug('LucHermitte/lh-vim-lib')
	Plug('jiangmiao/auto-pairs')
	Plug('danilamihailov/beacon.nvim')
	Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
	Plug('nvim-treesitter/nvim-treesitter-context')

	-- Harpooon
	Plug('nvim-lua/plenary.nvim')
	Plug('ThePrimeagen/harpoon')

	Plug('itchyny/lightline.vim')
	Plug('josa42/vim-lightline-coc')
vim.fn["plug#end"]()

local function pumVisible() return vim.fn["coc#pum#visible"]() end

function ShowDocumentation()
	local filetype = vim.bo.filetype
	if filetype == "vim" or filetype == "help" then
		vim.cmd("execute 'h '.expand('<cword>')")
	else
		vim.fn.CocAction('doHover')
	end
end


-- Navigate command mode completion menu with vim bindings (ctrl-j and ctrl-k)
vim.keymap.set("c", "<C-j>", function () if pumVisible() then return "<Tab>" end end, { expr = true})
vim.keymap.set("c", "<C-k>", function () if pumVisible() then return "<S-Tab>" end end, { expr = true})

vim.keymap.set("n", "src", function () vim.cmd.source("~/.config/nvim/init.lua") end, { noremap = true})
-- WhichKey seems to be broken after migrating to LUA. TODO: Remove since not used anyway
vim.keymap.set("n", "<Leader>?", ":WhichKey '<Leader>'<CR>", {silent = true})
vim.keymap.set("n", "<Leader>j", vim.cmd.jumps, {silent = true})
vim.keymap.set("n", "<Leader>o", vim.cmd.only, {silent = true, desc = "Close all windows but current"})
vim.keymap.set("n", "<Leader>u", vim.cmd.UndotreeToggle, {silent = true, desc = "UndoTree"})
vim.keymap.set("n", "<C-p>", vim.cmd.GFiles, {silent = true, desc = "FZF"})

-- Static colorscheme
-- colorscheme gotham

-- Pywal colorscheme
vim.cmd("colorscheme wal")
vim.o.termguicolors = false
vim.api.nvim_set_hl(0, "Pmenu", {ctermbg = 0}) -- "Use XResources background as popup menu color

function Upgrade()
	vim.cmd.PlugUpgrade()
	vim.cmd.PlugUpdate()
	vim.cmd.CocUpdate()
	vim.cmd.TSUpdate()
end
vim.api.nvim_create_user_command("Upgrade", Upgrade, {})

function ConflictsHighlight()
    vim.cmd("syn region conflictStart start=/^<<<<<<< .*$/ end=/^\\ze\\(=======$\\||||||||\\)/")
    vim.cmd("syn region conflictMiddle start=/^||||||| .*$/ end=/^\\ze=======$/")
    vim.cmd("syn region conflictEnd start=/^\\(=======$\\||||||| |\\)/ end=/^>>>>>>> .*$/")

		vim.api.nvim_set_hl(0, "conflictStart", {ctermbg = "red", ctermfg="black"})
		vim.api.nvim_set_hl(0, "conflictMiddle", {ctermbg = "blue", ctermfg="black"})
		vim.api.nvim_set_hl(0, "conflictEnd", {ctermbg = "green", ctermfg="black"})
end

vim.api.nvim_create_autocmd("BufEnter", {pattern = "*.ts", command = "set filetype=typescript" })
vim.api.nvim_create_autocmd("BufEnter", {pattern = "*.tsx", command = "set filetype=typescriptreact" })
vim.api.nvim_create_autocmd("BufEnter", {pattern = "*.pa", command = "set filetype=conf" })

local conflictColors = vim.api.nvim_create_augroup("ConflictColors", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
		callback = ConflictsHighlight,
		group = conflictColors,
})

local vimrchook = vim.api.nvim_create_augroup("vimrchook", { clear = true })
vim.api.nvim_create_autocmd("bufwritepost", {
		command = "source $MYVIMRC",
		group = vimrchook,
		pattern = "$MYVIMRC"
});

-- Treesitter
(function ()
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
end)();

-- Coc
(function ()
		vim.api.nvim_set_var("coc_snippet_next", "<C-l>")
		vim.api.nvim_set_var("coc_snippet_prev", "<C-h>")
		vim.api.nvim_set_var("coc_global_extensions", {
			'coc-tsserver',
			'coc-pyright',
			'coc-json',
			'coc-eslint',
			'coc-prettier',
			'coc-css',
			'coc-html',
			'coc-snippets',
			'coc-yaml',
			'coc-vimlsp',
			'coc-go',
			'coc-sh',
			'coc-docker',
			'coc-rust-analyzer',
			'coc-lua'
		})
		vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
		vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
		vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
		vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})
		vim.keymap.set("n", "gf", "<Plug>(coc-rename)", {silent = true})
		vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})
		-- Use `gn` and `gp` to navigate diagnostics
		-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
		vim.keymap.set("n", "gn", "<Plug>(coc-diagnostic-next)", {silent = true})
		vim.keymap.set("n", "gp", "<Plug>(coc-diagnostic-prev)", {silent = true})
		vim.keymap.set("i", "<c-space>", vim.fn["coc#refresh"], {silent = true})
		vim.keymap.set("n", "K", ShowDocumentation, {noremap = true, silent = true})
		-- Bind popup navigation to ctrl-j and ctrl-k
		vim.keymap.set("i", "<C-j>", function() if pumVisible() then vim.fn["coc#pum#next"](1) end end, {silent = true})
		vim.keymap.set("i", "<C-k>", function() if pumVisible() then vim.fn["coc#pum#prev"](1) end end, {silent = true})
		-- TODO: Can't figure out how to use <CR> here with vim.keymap.set. Figure it out.
		vim.keymap.set("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<CR>'", {silent = true, expr = true, noremap = true})

		vim.api.nvim_create_autocmd("User", {
			pattern = "CocOpenFloat",
			command = "setl nofen",
		})
end)();

-- NERDTree
(function ()
	-- Exit vim if nerdtree is the only window open
	-- TODO: Does this even work?
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "*",
		command = 'if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif'
	})

	vim.api.nvim_create_autocmd("StdinReadPre", {
		pattern = "*",
		callback = function ()
			vim.s.std_in=1
		end
	})
	vim.api.nvim_create_autocmd("VimEnter", {
		pattern = "*",
		command = 'if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe "NERDTree" argv()[0] | wincmd p | ene | exe "cd ".argv()[0] | endif'
	})

	vim.keymap.set("n", "<Leader>e", vim.cmd.NERDTreeToggle, {silent = true, noremap = true})
	vim.api.nvim_set_var("NERDTreeShowHidden",1)
	vim.api.nvim_set_var("NERDTreeAutoCenter",0)
	vim.api.nvim_set_var("NERDTreeSortHiddenFirst",0)
	vim.api.nvim_set_var("NERDTreeQuitOnOpen",1)
	vim.api.nvim_set_var("NERDTreeShowLineNumbers",1)
end)();

-- vim-test
(function()
	vim.api.nvim_set_var("test#strategy", "neovim")
	if vim.fn.has("nvim") then
		vim.keymap.set("t", "<C-o>", "<C-\\><C-n>", {})
	end


	vim.keymap.set("n", "t<C-n>", vim.cmd.TestNearest, {silent = true})
	vim.keymap.set("n", "t<C-f>", vim.cmd.TestFile,  {silent = true})
	vim.keymap.set("n", "t<C-s>", vim.cmd.TestSuite, {silent = true})
	vim.keymap.set("n", "t<C-l>", vim.cmd.TestLast,  {silent = true})
	vim.keymap.set("n", "t<C-g>", vim.cmd.TestVisit, {silent = true})
end)();

-- harpoon
(function()
	local harpoon_ui = require('harpoon.ui')
	local harpoon_mark = require('harpoon.mark')
	local function harpoon_nav_file(index)
		return function () harpoon_ui.nav_file(index) end
	end
	vim.keymap.set("n", "<Leader>1", harpoon_nav_file(1), {silent = true})
	vim.keymap.set("n", "<Leader>2", harpoon_nav_file(2), {silent = true})
	vim.keymap.set("n", "<Leader>3", harpoon_nav_file(3), {silent = true})
	vim.keymap.set("n", "<Leader>4", harpoon_nav_file(4), {silent = true})
	vim.keymap.set("n", "<Leader>nn", harpoon_ui.toggle_quick_menu, {silent = true})
	vim.keymap.set("n", "<Leader>na", harpoon_mark.add_file)
end)();

-- vim-fugitive
(function()
	vim.keymap.set("n", "<Leader>gd", vim.cmd.Gdiffsplit, {silent = true})
	vim.keymap.set("n", "<Leader>gs", vim.cmd.Gstatus, {silent = true})
	vim.keymap.set("n", "<Leader>gh", vim.cmd.diffget, {silent = true})
	vim.keymap.set("n", "<Leader>gl", vim.cmd.diffhet, {silent = true})
	vim.keymap.set("n", "<Leader>gb", vim.cmd.Gblame, {silent = true})
end)();

-- vim-tmux-runner
(function()
	vim.keymap.set("n", "<Leader>tc", vim.cmd.VtrSendCommandToRunner, {})
	vim.keymap.set("n", "<Leader>to", vim.cmd.VtrOpenRunner, {})
	vim.keymap.set("n", "<Leader>tk", vim.cmd.VtrKillRunner, {})
	vim.keymap.set("n", "<Leader>tf", vim.cmd.VtrFocusRunner, {})
	vim.keymap.set("n", "<Leader>tl", vim.cmd.VtrSendLinesToRunner, {})
	vim.keymap.set("v", "<Leader>tl", vim.cmd.VtrSendLinesToRunner, {})
end)();

-- vim-dap
(function ()
	require("dapui").setup()
	require("nvim-dap-virtual-text").setup({
		highlight_changed_variables = true
	})

	local dap, dapui = require('dap'), require('dapui')

	dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
	dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
	dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

	vim.keymap.set("n", "<Leader>dc", dap.continue, {silent = true})
	vim.keymap.set("n", "<Leader>dj", dap.step_over, {silent = true})
	vim.keymap.set("n", "<Leader>dl", dap.step_into, {silent = true})
	vim.keymap.set("n", "<Leader>dk", dap.step_out, {silent = true})
	vim.keymap.set("n", "<Leader>dgc", dap.run_to_cursor, {silent = true})
	vim.keymap.set("n", "<Leader>dbp", dap.toggle_breakpoint, {silent = true})
	vim.keymap.set("n", "<Leader>dr", dap.repl.open, {silent = true})
	vim.keymap.set("n", "<Leader>di", dapui.eval, {silent = true})
	vim.keymap.set("v", "<Leader>di", dapui.eval, {silent = true})
	vim.keymap.set("n", "<Leader>de", dap.terminate, {silent = true})

	vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermfg=52 })
	vim.api.nvim_set_hl(0, "DapStopped", { ctermfg=22, ctermbg=7 })
	vim.fn.sign_define('DapBreakpoint', {text='', texthl='DapBreakpoint'})
	vim.fn.sign_define('DapStopped', {text='', texthl='DapStopped', linehl='DapStopped', numhl='DapStopped'})

	require("dap-go").setup({
	 on_attach = function()
	 end
	})
end)();

-- lightline
(function ()
	-- TODO: Figure out how to write these functions purely in lua
	vim.api.nvim_exec(
	[[
		function! LightLineFullPath() 
			return expand('%')
		endfunction
	]]
	, false)
	vim.api.nvim_exec(
	[[
		function! LightLineReadonly()
			return &readonly ? '' : ''
		endfunction
	]]
	, false)

	vim.g.lightline = {
		colorscheme = 'wal',
		separator = { left = '', right =  ''},
		active = {
			left = {
					{'gitbranch', 'readonly', 'filename', 'modified'},
					{'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok'},
					{'coc_status'}
			},
			right = {
				{
					'lineinfo'
				}
			}
		},
		component_function = {
			readonly = "LightLineReadonly",
			filename = "LightLineFullPath",
			gitbranch = "FugitiveHead"
		}
	}

	vim.fn["lightline#coc#register"]()
end)();

-- tmuxline
(function ()
	vim.g.tmuxline_preset = {
      a    = '#S',
      win  = '#I #W',
      cwin = '#I #W',
      z    = '#H',
			options= { ["status-justify"] = 'left'}
	}
end)();

-- indentline
(function ()
	-- The plugin messes up quotes in these filetypes
	vim.g.indentLine_fileTypeExclude = { "markdown", "json" }
end)();

-- localvimrc
(function ()
	vim.fn["lh#local_vimrc#filter_list"]("asklist", "v:val != $HOME")
end)();

-- fzf
(function ()
	vim.keymap.set("n", "<Leader>c", vim.cmd.Command)
end)();

-- beacon
(function ()
	vim.g.beacon_size=100
	vim.g.beacon_minimal_jump=1
end)();
