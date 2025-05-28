require 'nvim-treesitter.configs'.setup {
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
		"templ",
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
