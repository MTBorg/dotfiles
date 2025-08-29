local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')

require 'lazydev'.setup {}

vim.keymap.set('n', 'gf', vim.lsp.buf.rename)
vim.keymap.set("n", "gn", vim.diagnostic.goto_next)
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev)

vim.keymap.set('n', 'K', function()
	require("pretty_hover").hover()
end)
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		-- Format the current buffer on save
		-- TODO: instead of disabling format on save figure out how to integrate with prettier
		if client.supports_method('textDocument/formatting') and client.name ~= "eslint" and client.name ~= "ts_ls" then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
				end,
			})
		end
	end,
})



vim.lsp.config('gopls', {
	capabilities = capabilities,
})

vim.lsp.config('lua_ls', {
	capabilities = capabilities,
})

vim.lsp.config('volar', {
	filetypes = { 'vue' },
	init_options = {
		vue = {
			hybridMode = false,
		},
	},
})

vim.lsp.config('elixirls', {
	capabilities = capabilities,
	cmd = { "/opt/homebrew/bin/elixir-ls" },
})

vim.lsp.config('eslint', {
	capabilities = capabilities,
})

vim.lsp.config('ts_ls', {
	capabilities = capabilities,
})

vim.lsp.config('graphql', {
	capabilities = capabilities,
})

vim.lsp.config('dockerls', {
	capabilities = capabilities,
})

vim.lsp.config('docker_compose_language_service', {
	capabilities = capabilities,
})

vim.lsp.config('buf_ls', {
	capabilities = capabilities,
})

vim.lsp.config('pyright', {
	capabilities = capabilities,
})

vim.lsp.config('csharp_ls', {
	capabilities = capabilities,
	AutomaticWorkspaceInit = true
})

vim.lsp.config('templ', {
	capabilities = capabilities,
})

vim.lsp.config('html', {
	capabilities = capabilities,
	filetypes = { "html", "templ" },
})

vim.lsp.config('jsonls', {
	capabilities = capabilities,
})

vim.lsp.config('rust_analyzer', {
	capabilities = capabilities,
})
