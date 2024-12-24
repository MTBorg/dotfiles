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

lspconfig.gopls.setup {
	capabilities = capabilities,
}

lspconfig.lua_ls.setup {
	capabilities = capabilities,
}

lspconfig.volar.setup {
	filetypes = { 'vue' },
	init_options = {
		vue = {
			hybridMode = false,
		},
	},
}

lspconfig.elixirls.setup {
	capabilities = capabilities,
	cmd = { "/opt/homebrew/bin/elixir-ls" },
}

lspconfig.eslint.setup {
	capabilities = capabilities,
}

lspconfig.ts_ls.setup {
	capabilities = capabilities,
}

lspconfig.graphql.setup {
	capabilities = capabilities,
}

lspconfig.dockerls.setup {
	capabilities = capabilities,
}

lspconfig.docker_compose_language_service.setup {
	capabilities = capabilities,
}

lspconfig.buf_ls.setup {
	capabilities = capabilities,
}

lspconfig.pyright.setup {
	capabilities = capabilities,
}

lspconfig.csharp_ls.setup {
	capabilities = capabilities,
	AutomaticWorkspaceInit = true
}
