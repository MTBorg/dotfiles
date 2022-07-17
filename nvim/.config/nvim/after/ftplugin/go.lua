vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	command = ":silent call CocAction('runCommand', 'editor.action.organizeImport')"
})
