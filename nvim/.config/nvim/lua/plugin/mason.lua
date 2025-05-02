require("mason").setup()
require("mason-lspconfig").setup({
	automatic_installation = true,
	ensure_installed = {
		"bashls",
		"buf_ls", -- protobuf
		"clangd", -- c
		-- TODO: Installing cmake ls fails because of an invalid python version
		-- "cmake",
		"cssls",
		"csharp_ls",
		"dockerls",
		"docker_compose_language_service",
		"elixirls",
		"gopls",
		"helm_ls",
		"lua_ls",
		"eslint", -- javascript/typescript
		"graphql",
		"html",
		"jsonls",
		"marksman", -- markdown
		"pyright", -- python
		"rust_analyzer",
		"sqls",
		"terraformls",
		"ts_ls", -- typescript
		"vimls",

		"vuels",
		"volar" -- vue
	}
})
