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
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 }
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	'nvim-tree/nvim-tree.lua',
	'tpope/vim-fugitive',
	'airblade/vim-gitgutter',

	-- Tmux
	'edkolev/tmuxline.vim',
	'christoomey/vim-tmux-runner',
	'christoomey/vim-tmux-navigator',

	-- Coc
	{'neoclide/coc.nvim', branch = "release", build = "yarn install --frozen-lockfile"},
	'antoinemadec/coc-fzf',

	-- Fzf
	'junegunn/fzf',
	'junegunn/fzf.vim',

	-- nvim-dap
	'mfussenegger/nvim-dap',
	'leoluz/nvim-dap-go',
	'rcarriga/nvim-dap-ui',
	'theHamsta/nvim-dap-virtual-text',

	-- Styling
	'whatyouhide/vim-gotham',
	'dylanaraps/wal.vim',
	'olimorris/onedarkpro.nvim',
	'levouh/tint.nvim',
	'nvim-tree/nvim-web-devicons',
	'folke/tokyonight.nvim',

	-- Language packs
	'baskerville/vim-sxhkdrc',

	-- Treesitter
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
	'nvim-treesitter/nvim-treesitter-context',
	'nvim-treesitter/nvim-treesitter-textobjects',
	'Wansmer/treesj',

	-- Misc
	'janko/vim-test',
	'tpope/vim-repeat',
	'tpope/vim-commentary',
	'tpope/vim-surround',
	'lukas-reineke/indent-blankline.nvim', 
	'honza/vim-snippets',
	'mbbill/undotree',
	'LucHermitte/lh-vim-lib',
	'jiangmiao/auto-pairs',
	'danilamihailov/beacon.nvim',
	'folke/zen-mode.nvim',
	'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
	'ThePrimeagen/refactoring.nvim',
	'github/copilot.vim',
	'stevearc/oil.nvim',
	'nvim-neotest/nvim-nio',

	-- telescope
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	'fannheyward/telescope-coc.nvim',

	-- Harpooon
	'nvim-lua/plenary.nvim',
	'ThePrimeagen/harpoon',

	'nvim-lualine/lualine.nvim',
})

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
-- vim.keymap.set("n", "<C-p>", vim.cmd.GFiles, {silent = true, desc = "FZF"})

-- center view on jumps/searches
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- move blocks of text without deleting
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("i", 'jk', '<Esc>', { noremap = true, silent = true })
vim.keymap.set("i", 'kj', '<Esc>', { noremap = true, silent = true })

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
vim.api.nvim_create_autocmd("BufEnter", {pattern = "*.zshrc", command = "set filetype=zsh" })

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
			"sql",
			"toml",
			"typescript",
			"vim",
			"vimdoc",
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
			'coc-vetur'
			-- 'coc-lua'
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
		vim.keymap.set("i", "<C-q>", vim.fn["coc#refresh"], {silent = true, noremap = true, expr = true})
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
			},
			filters = {
				dotfiles = false,
				git_ignored = false
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

-- fzf
(function ()
	-- vim.keymap.set("n", "<Leader>c", vim.cmd.Command)
	-- vim.keymap.set("n", "<Leader>b", vim.cmd.Buffers)
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
	require("ibl").setup()
end)();

-- copilot
(function ()
	vim.keymap.set("i", "<PageUp>", "<Plug>(copilot-next)", {silent = true, noremap = true})
	vim.keymap.set("i", "<PageDown>", "<Plug>(copilot-previous)", {silent = true, noremap = true})
end)();

-- oil.nvim
(function ()
	require("oil").setup()
end)();

-- treesj
(function ()
	require("treesj").setup()
end)();

-- vim-commentary
(function ()
	vim.api.nvim_create_autocmd("FileType", {pattern = "terraform", command = "setlocal commentstring=//%s" })
	vim.api.nvim_create_autocmd("FileType", {pattern = "proto", command = "setlocal commentstring=//%s" })
end)();

-- telescope
(function()
	require("telescope").setup({
		pickers = {
			find_files = {
				hidden = true
			}
		},
		defaults = {
			file_ignore_patterns = {
				"gen/.+%.go$",
				".*/pkg/go/mod/.*",
				".git/.*"
			}
		},
		extensions = {
			coc = {
				theme = 'ivy',
				prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
				push_cursor_on_edit = true, -- save the cursor position to jump back in the future
				timeout = 3000, -- timeout for coc commands
			}
		},
	})
	require('telescope').load_extension('coc')

	local builtin = require('telescope.builtin')
	-- local extensions = require('telescope').extensions
	vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
	vim.keymap.set('n', '<leader>fc', builtin.commands, {})
	vim.keymap.set('n', '<leader>fs', require('telescope').extensions.coc.workspace_symbols)
	vim.keymap.set('n', '<leader>fr', require('telescope').extensions.coc.references)

end)();


-- source device specific config if it exists
local configHome = os.getenv('XDG_CONFIG_HOME') or vim.fn.expand('$HOME/.config')
local deviceConfig = configHome .. '/nvim/device.init.lua'
if vim.fn.filereadable(deviceConfig) ~= 0 then dofile(deviceConfig) end
