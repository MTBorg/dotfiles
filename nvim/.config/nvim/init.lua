vim.keymap.set("n", "<SPACE>", "", {noremap = true})
vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
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
vim.o.cc = "80"
vim.o.termguicolors = true -- "Enable true colors
vim.o.updatetime = 200 -- "This makes the git gutter update faster
vim.o.swapfile = false
vim.o.numberwidth = 1
vim.o.encoding = "UTF-8"
vim.o.splitright = true
vim.o.foldlevel=0
vim.wo.foldmethod="expr"
vim.wo.foldexpr="nvim_treesitter#foldexpr()"
vim.o.showmode = false -- "Don't show mode as this is shown by the lightline plugin
vim.o.conceallevel = 0
-- This is necessary to use tab in command mode key bindings
vim.o.wildcharm = ('\t'):byte()
vim.o.signcolumn = "auto:1-9"

vim.fn["plug#begin"]("~/.local/share/nvim/plugged/")
	local Plug = vim.fn["plug#"]

	-- NERDTree
	Plug('nvim-tree/nvim-tree.lua')

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
	Plug('whatyouhide/vim-gotham')
	Plug('dylanaraps/wal.vim')
	Plug('olimorris/onedarkpro.nvim')
	Plug('levouh/tint.nvim')
	Plug('nvim-tree/nvim-web-devicons')
	Plug('folke/tokyonight.nvim')

	-- Language packs
	Plug('baskerville/vim-sxhkdrc')

	-- Treesitter
	Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate'})
	Plug('nvim-treesitter/nvim-treesitter-context')
	Plug('nvim-treesitter/nvim-treesitter-textobjects')

	-- Misc
	Plug('janko/vim-test')
	Plug('tpope/vim-repeat')
	Plug('tpope/vim-commentary')
	Plug('tpope/vim-surround')
	Plug('lukas-reineke/indent-blankline.nvim', {['tag'] = "v2.20.8"})
	Plug('honza/vim-snippets')
	Plug('mbbill/undotree')
	Plug('LucHermitte/local_vimrc')
	Plug('LucHermitte/lh-vim-lib')
	Plug('jiangmiao/auto-pairs')
	Plug('danilamihailov/beacon.nvim')
	Plug('folke/zen-mode.nvim')
	Plug('https://git.sr.ht/~whynothugo/lsp_lines.nvim')
	Plug('ThePrimeagen/refactoring.nvim')
	Plug('github/copilot.vim')

	-- Harpooon
	Plug('nvim-lua/plenary.nvim')
	Plug('ThePrimeagen/harpoon')

	Plug('nvim-lualine/lualine.nvim')
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
vim.keymap.set("n", "<Leader>j", vim.cmd.jumps, {silent = true})
vim.keymap.set("n", "<Leader>o", vim.cmd.only, {silent = true, desc = "Close all windows but current"})
vim.keymap.set("n", "<Leader>u", vim.cmd.UndotreeToggle, {silent = true, desc = "UndoTree"})
vim.keymap.set("n", "<C-p>", vim.cmd.GFiles, {silent = true, desc = "FZF"})

-- center view on jumps/searches
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- move blocks of text without deleting
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

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
			"diff",
			"dockerfile",
			"go",
			"gomod",
			"gitignore",
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
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-n>",
				node_incremental = "<C-n>",
				node_decremental = "<C-m>",
				scope_incremental = "<C-b>",
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
				},
			}
		}
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
		vim.keymap.set("i", "<C-space>", vim.fn["coc#refresh"], {silent = true, noremap = true, expr = true})
		vim.keymap.set("n", "K", ShowDocumentation, {noremap = true, silent = true})
		-- Bind popup navigation to ctrl-j and ctrl-k
		vim.keymap.set("i", "<C-j>", function() if pumVisible() then return vim.fn["coc#pum#next"](1) end end, {expr = true})
		vim.keymap.set("i", "<C-k>", function() if pumVisible() then return vim.fn["coc#pum#prev"](1) end end, {expr = true})
		-- TODO: Can't figure out how to use <CR> here with vim.keymap.set. Figure it out.
		vim.keymap.set("i", "<CR>", "coc#pum#visible() ? coc#pum#confirm() : '<CR>'", {silent = true, expr = true, noremap = true})

		vim.api.nvim_create_user_command("CocSymbols", function () vim.cmd("CocList symbols") end, {})

		vim.api.nvim_create_autocmd("User", {
			pattern = "CocOpenFloat",
			command = "setl nofen",
		})
end)();

-- nvim-tree
(function ()
	require("nvim-tree").setup(
		{
			view = {
				relativenumber = true,
				adaptive_size = true
			},
			actions = {
				open_file = {
					quit_on_open = true
				}
			}
		}
	)

	vim.keymap.set("n", "<Leader>e", vim.cmd.NvimTreeToggle, {silent = true, noremap = true})
end)();

-- vim-test
(function()
	vim.api.nvim_set_var("test#strategy", "neovim")
	vim.api.nvim_set_var("test#neovim#start_normal", 1)

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

	vim.api.nvim_create_user_command("DAPClearBreakpoints", function () dap.clear_breakpoints() end, {})

	dap.adapters.lldb = {
		type = 'executable',
		command = '/usr/bin/lldb-vscode',
		name = 'lldb'
	}

	dap.configurations.rust = {
		{
			name = 'Launch',
			type = 'lldb',
			request = 'launch',
			program = function()
				local components = vim.split(vim.fn.getcwd(), "/")
				return vim.fn.getcwd() .. "/target/debug/" .. components[#components]
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			args = {},
		},
		{
			name = 'Launch (manual)',
			type = 'lldb',
			request = 'launch',
			program = function()
				return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/', 'file')
			end,
			cwd = '${workspaceFolder}',
			stopOnEntry = false,
			args = function()
				local input = vim.fn.input("args: ")
				local args = {}
				for word in string.gmatch(input, "%w+") do
					table.insert(args, word)
				end
				return args
			end,
		}
	}

	vim.api.nvim_create_user_command("DapScope", function ()
    local widgets = require "dap.ui.widgets";
    widgets.centered_float(widgets.scopes)
	end, {})

	vim.api.nvim_create_user_command("DapHover", function ()
    require "dap.ui.widgets".hover()
	end, {})

	require('dap-go').setup {
		delve = {
			port = "38697"
		},
		dap_configurations = {
			{
				type = "go",
				name = "Attach remote",
				mode = "remote",
				request = "attach",
			}
		}
	}
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

-- localvimrc
(function ()
	vim.fn["lh#local_vimrc#filter_list"]("asklist", "v:val != $HOME")
end)();

-- fzf
(function ()
	vim.keymap.set("n", "<Leader>c", vim.cmd.Command)
	vim.keymap.set("n", "<Leader>b", vim.cmd.Buffers)
end)();

-- beacon
(function ()
	vim.g.beacon_size=100
	vim.g.beacon_minimal_jump=1
end)();

(function ()
	require("zen-mode").setup()
end)();

(function ()
	require("lsp_lines").setup()
end)();

-- refactoring
(function ()
	require("refactoring").setup({})

	vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]], {noremap = true, silent = true, expr = false})
	vim.api.nvim_set_keymap("v", "<leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]], {noremap = true, silent = true, expr = false})
	vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]], {noremap = true, silent = true, expr = false})
	vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]], {noremap = true, silent = true, expr = false})
end)();

-- tint
(function ()
	require("tint").setup({
		tint = -20,  -- Darken colors, use a positive value to brighten
		saturation = 0,  -- Saturation to preserve
	})
end)();

-- lualine
(function ()
	require('lualine').setup({
		options = {
			theme = 'tokyonight'
		},
		sections = {
			lualine_x = {}
		}
	})
end)();

-- indent-blankline
(function ()
	require("indent_blankline").setup({
		show_current_context = true,
    show_current_context_start = true,
	})
end)();
