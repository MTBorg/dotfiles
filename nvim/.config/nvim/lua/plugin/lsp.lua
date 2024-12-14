local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')

require 'lspconfig'.gopls.setup {}
require 'lspconfig'.lua_ls.setup {}
require 'lazydev'.setup {}

vim.keymap.set('n', 'gf', vim.lsp.buf.rename)
vim.keymap.set("n", "gn", vim.diagnostic.goto_next)
vim.keymap.set("n", "gp", vim.diagnostic.goto_prev)

local servers = { 'gopls' }
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	}
end

vim.keymap.set('n', 'K', function()
	require("pretty_hover").hover()
end)
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		-- Format the current buffer on save
		if client.supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
				end,
			})
		end
	end,
})
