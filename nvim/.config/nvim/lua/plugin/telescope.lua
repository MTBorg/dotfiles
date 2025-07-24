require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true
		}
	},
	defaults = {
		layout_config = {
			horizontal = {
				width = { padding = 1 },
				height = { padding = 1 }
			}
		},
		path_display = {
			"truncate"
		},
		file_ignore_patterns = {
			"gen/.+%.go$",
			".*/pkg/go/mod/.*",
			".git/.*",
			".yarn/releases/.*",
			"yarn.lock",
			"vendor/.*",

			-- rust
			"target/.*",
		},
	},
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fc', builtin.commands, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>fs', builtin.lsp_dynamic_workspace_symbols)
vim.keymap.set('n', '<leader>fwd', builtin.diagnostics)
vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations)
vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions)
vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions)
require("telescope").load_extension("ui-select")
