require('avante').setup({
	provider = "mistral",
	vendors = {
		mistral = {
			__inherited_from = "openai",
			api_key_name = "MISTRAL_API_KEY",
			endpoint = "https://api.mistral.ai/v1/",
			model = "mistral-large-latest",
			max_tokens = 4096, -- to avoid using max_completion_tokens
		},
	},
})

vim.keymap.set('n', '<leader>ai', ':AvanteToggle <CR>', { noremap = true, silent = true })
