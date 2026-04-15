require('nvim-treesitter').install {
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
	"helm",
	"html",
	"http",
	"javascript",
	"json",
	"json5",
	"lua",
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
}

-- Incremental selection (built into neovim, removed from nvim-treesitter v1)
local sel = require('vim.treesitter._select')
vim.keymap.set('n', '<C-n>', function() sel.select_parent(1) end)
vim.keymap.set('x', '<C-n>', function() sel.select_parent(vim.v.count1) end)
vim.keymap.set('x', '<C-m>', function() sel.select_child(vim.v.count1) end)
vim.keymap.set('x', '<C-b>', function() sel.select_next(vim.v.count1) end)

require('nvim-treesitter-textobjects').setup({
	select = {
		lookahead = true,
	},
})

vim.keymap.set({ 'x', 'o' }, 'af', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@function.outer')
end)
vim.keymap.set({ 'x', 'o' }, 'if', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@function.inner')
end)

-- This filetype pattern lets treesitter-helm detect helm templates.
vim.filetype.add({
	pattern = {
		[".*/templates/.*%.tpl"] = "helm",
		[".*/templates/.*%.ya?ml"] = "helm",
		["helmfile.*%.ya?ml"] = "helm",
	},
})
