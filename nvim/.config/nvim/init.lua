vim.keymap.set("n", "<SPACE>", "", { noremap = true })
vim.g.mapleader          = " "
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1
vim.o.syntax             = "off"
vim.o.compatible         = false
vim.o.showmatch          = true
vim.o.hlsearch           = true
vim.o.tabstop            = 2
vim.o.softtabstop        = 2
vim.o.expandtab          = false
vim.o.shiftwidth         = 2
vim.o.autoindent         = true
vim.o.number             = true
vim.o.relativenumber     = true
vim.o.cc                 = "80"
vim.o.termguicolors      = true -- "Enable true colors
vim.o.updatetime         = 200  -- "This makes the git gutter update faster
vim.o.swapfile           = false
vim.o.numberwidth        = 1
vim.o.encoding           = "UTF-8"
vim.o.splitright         = true
vim.wo.foldlevel         = 99 -- "Open all folds by default
vim.wo.foldmethod        = "expr"
vim.wo.foldexpr          = "nvim_treesitter#foldexpr()"
vim.o.showmode           = false -- "Don't show mode as this is shown by the lightline plugin
vim.o.conceallevel       = 0
-- This is necessary to use tab in command mode key bindings
vim.o.wildcharm          = ('\t'):byte()
vim.o.signcolumn         = "auto:1-9"
vim.api.nvim_create_autocmd('TextYankPost', {
	group = vim.api.nvim_create_augroup('highlight_yank', {}),
	desc = 'Hightlight selection on yank',
	pattern = '*',
	callback = function()
		vim.highlight.on_yank { higroup = 'IncSearch', timeout = 300 }
	end,
})
vim.diagnostic.config({
	virtual_text = false
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
	-- Tmux
	'edkolev/tmuxline.vim',
	'christoomey/vim-tmux-runner',
	'christoomey/vim-tmux-navigator',

	-- Fzf
	'junegunn/fzf',
	'junegunn/fzf.vim',

	-- nvim-dap
	'mfussenegger/nvim-dap',
	'leoluz/nvim-dap-go',
	'rcarriga/nvim-dap-ui',
	'theHamsta/nvim-dap-virtual-text',
	'mfussenegger/nvim-dap-python',

	-- Styling
	'levouh/tint.nvim',
	'nvim-tree/nvim-web-devicons',
	'folke/tokyonight.nvim',
	{
		"Fildo7525/pretty_hover",
		event = "LspAttach",
		opts = {}
	},

	-- Language packs
	'baskerville/vim-sxhkdrc',

	-- Treesitter
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	'nvim-treesitter/nvim-treesitter-context',
	'nvim-treesitter/nvim-treesitter-textobjects',
	'Wansmer/treesj',

	-- LSP
	'neovim/nvim-lspconfig',
	-- TODO: Figure out a way to not have to install a separate package manager
	-- for this, or just switch to mason.
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- nvim-cmp
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-nvim-lsp',

	-- Snippets
	'saadparwaiz1/cmp_luasnip',
	'L3MON4D3/LuaSnip',
	{
		'L3MON4D3/LuaSnip',
		version = 'v2.*'
	},
	'honza/vim-snippets', -- TODO: Delete if deprecated by new snippet plugins

	-- for customizing vim.ui.input
	'stevearc/dressing.nvim',

	-- Misc
	'janko/vim-test',
	'tpope/vim-repeat',
	'tpope/vim-commentary',
	'tpope/vim-surround',
	'lukas-reineke/indent-blankline.nvim',
	'mbbill/undotree',
	'LucHermitte/lh-vim-lib',
	'jiangmiao/auto-pairs',
	'danilamihailov/beacon.nvim',
	'ThePrimeagen/refactoring.nvim',
	'github/copilot.vim',
	'stevearc/oil.nvim',
	'nvim-neotest/nvim-nio',
	'olexsmir/gopher.nvim',
	'nvim-tree/nvim-tree.lua',
	'tpope/vim-fugitive',
	'airblade/vim-gitgutter',
	'sindrets/diffview.nvim',
	{ 'akinsho/git-conflict.nvim',       version = "*",      config = true },
	{
		'yetone/avante.nvim',
		build = "make",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	},

	-- telescope
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.6',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},
	'nvim-telescope/telescope-ui-select.nvim',

	-- Harpooon
	{
		'ThePrimeagen/harpoon',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},

	'nvim-lualine/lualine.nvim',
})

vim.keymap.set("n", "src", function() vim.cmd.source("~/.config/nvim/init.lua") end, { noremap = true })
vim.keymap.set("n", "<Leader>u", vim.cmd.UndotreeToggle, { silent = true, desc = "UndoTree" })
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

vim.keymap.set("n", "<Leader>cn", vim.cmd.cnext, { silent = true })
vim.keymap.set("n", "<Leader>cp", vim.cmd.cprevious, { silent = true })

vim.cmd("colorscheme tokyonight")

function Upgrade()
	vim.cmd.PlugUpgrade()
	vim.cmd.PlugUpdate()
	vim.cmd.TSUpdate()
end

vim.api.nvim_create_user_command("Upgrade", Upgrade, {})

vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.ts", command = "set filetype=typescript" })
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.tsx", command = "set filetype=typescriptreact" })
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.pa", command = "set filetype=conf" })
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*.zshrc", command = "set filetype=zsh" })

local vimrchook = vim.api.nvim_create_augroup("vimrchook", { clear = true })
vim.api.nvim_create_autocmd("bufwritepost", {
	command = "source $MYVIMRC",
	group = vimrchook,
	pattern = "$MYVIMRC"
});

-- nvim-tree
(function()
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

	vim.keymap.set("n", "<Leader>e", vim.cmd.NvimTreeToggle, { silent = true, noremap = true })
end)();

-- vim-test
(function()
	vim.api.nvim_set_var("test#strategy", "neovim")
	vim.api.nvim_set_var("test#neovim#start_normal", 1)

	vim.keymap.set("n", "t<C-n>", vim.cmd.TestNearest, { silent = true })
	vim.keymap.set("n", "t<C-f>", vim.cmd.TestFile, { silent = true })
	vim.keymap.set("n", "t<C-s>", vim.cmd.TestSuite, { silent = true })
	vim.keymap.set("n", "t<C-l>", vim.cmd.TestLast, { silent = true })
	vim.keymap.set("n", "t<C-g>", vim.cmd.TestVisit, { silent = true })
end)();

-- harpoon
(function()
	local harpoon_ui = require('harpoon.ui')
	local harpoon_mark = require('harpoon.mark')
	local function harpoon_nav_file(index)
		return function() harpoon_ui.nav_file(index) end
	end
	vim.keymap.set("n", "<Leader>1", harpoon_nav_file(1), { silent = true })
	vim.keymap.set("n", "<Leader>2", harpoon_nav_file(2), { silent = true })
	vim.keymap.set("n", "<Leader>3", harpoon_nav_file(3), { silent = true })
	vim.keymap.set("n", "<Leader>4", harpoon_nav_file(4), { silent = true })
	vim.keymap.set("n", "<Leader>nn", harpoon_ui.toggle_quick_menu, { silent = true })
	vim.keymap.set("n", "<Leader>na", harpoon_mark.add_file)
end)();

-- vim-fugitive
(function()
	vim.keymap.set("n", "<Leader>gd", vim.cmd.Gdiffsplit, { silent = true })
	vim.keymap.set("n", "<Leader>gs", vim.cmd.Gstatus, { silent = true })
	vim.keymap.set("n", "<Leader>gh", vim.cmd.diffget, { silent = true })
	vim.keymap.set("n", "<Leader>gl", vim.cmd.diffhet, { silent = true })
	vim.keymap.set("n", "<Leader>gb", vim.cmd.Gblame, { silent = true })
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

-- tmuxline
(function()
	vim.g.tmuxline_preset = {
		a       = '#S',
		win     = '#I #W',
		cwin    = '#I #W',
		z       = '#H',
		options = { ["status-justify"] = 'left' }
	}
end)();

-- beacon
(function()
	vim.g.beacon_size = 100
	vim.g.beacon_minimal_jump = 1
end)();

-- refactoring
(function()
	require("refactoring").setup({})

	vim.api.nvim_set_keymap("v", "<leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
		{ noremap = true, silent = true, expr = false })
	vim.api.nvim_set_keymap("v", "<leader>rf",
		[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
		{ noremap = true, silent = true, expr = false })
	vim.api.nvim_set_keymap("v", "<leader>rv", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
		{ noremap = true, silent = true, expr = false })
	vim.api.nvim_set_keymap("v", "<leader>ri", [[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
		{ noremap = true, silent = true, expr = false })
end)();

-- tint
(function()
	require("tint").setup({
		tint = -20,   -- Darken colors, use a positive value to brighten
		saturation = 0, -- Saturation to preserve
	})
end)();

-- lualine
(function()
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
(function()
	require("ibl").setup()
end)();

-- copilot
(function()
	vim.keymap.set("i", "<PageUp>", "<Plug>(copilot-next)", { silent = true, noremap = true })
	vim.keymap.set("i", "<PageDown>", "<Plug>(copilot-previous)", { silent = true, noremap = true })
	vim.keymap.set('i', '<C-f>', 'copilot#Accept("\\<CR>")', {
		expr = true,
		replace_keycodes = false
	})
	vim.g.copilot_no_tab_map = true
end)();

-- oil.nvim
(function()
	require("oil").setup()
end)();

-- treesj
(function()
	require("treesj").setup()
end)();

-- vim-commentary
(function()
	vim.api.nvim_create_autocmd("FileType", { pattern = "terraform", command = "setlocal commentstring=//%s" })
	vim.api.nvim_create_autocmd("FileType", { pattern = "proto", command = "setlocal commentstring=//%s" })
end)();

-- git-conflict
(function()
	require 'git-conflict'.setup()
	vim.keymap.set('n', '<Leader>gco', '<Plug>(git-conflict-ours)')
	vim.keymap.set('n', '<Leader>gct', '<Plug>(git-conflict-theirs)')
	vim.keymap.set('n', '<Leader>gcb', '<Plug>(git-conflict-both)')
	vim.keymap.set('n', '<Leader>gc0', '<Plug>(git-conflict-none)')
	vim.keymap.set('n', '<Leader>g[x', '<Plug>(git-conflict-prev-conflict)')
	vim.keymap.set('n', '<Leader>g]x', '<Plug>(git-conflict-next-conflict)')
end)();

require 'plugin/mason'
require 'plugin/lsp'
require 'plugin/cmp'
require 'plugin/telescope'
require 'plugin/treesitter'
require 'plugin/luasnip'
require 'plugin/dap'
require 'plugin/avante'

vim.keymap.set('n', '<leader>fa', vim.lsp.buf.code_action)

-- source device specific config if it exists
local configHome = os.getenv('XDG_CONFIG_HOME') or vim.fn.expand('$HOME/.config')
local deviceConfig = configHome .. '/nvim/device.init.lua'
if vim.fn.filereadable(deviceConfig) ~= 0 then dofile(deviceConfig) end
-- Create a keymap for vim.lsp.buf.implementation
--
--
