local cmp = require 'cmp'
local luasnip = require 'luasnip'
local types = require("cmp.types")
require("luasnip.loaders.from_snipmate").lazy_load()

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
	},
	preselect = cmp.PreselectMode.None,
	mapping = cmp.mapping.preset.insert({
		['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
		['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
		['<C-q>'] = cmp.mapping.complete(),
		['<C-h>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<C-l>'] = cmp.mapping(function(fallback)
			if luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<C-j>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<C-k>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lsp',               priority = 9 },
		{ name = 'luasnip', },
		{ name = 'buffer' },
		{ name = 'path' }
	},
	sorting = {
		priority_weight = 1,
		-- Useful links:
		-- https://github.com/hrsh7th/nvim-cmp/issues/883#issuecomment-1094512075
		-- https://github.com/hrsh7th/nvim-cmp/issues/883#issuecomment-1094513187
		-- https://github.com/pysan3/dotfiles/blob/9d3ca30baecefaa2a6453d8d6d448d62b5614ff2/nvim/lua/plugins/70-nvim-cmp.lua#L132-L162
		comparators = {
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
				---@type table<integer, integer>
				local modified_priority = {
					[types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
					[types.lsp.CompletionItemKind.Snippet] = 0, -- top
					[types.lsp.CompletionItemKind.Keyword] = 0, -- top
					[types.lsp.CompletionItemKind.Text] = 100, -- bottom
				}
				---@param kind integer: kind of completion entry
				local function modified_kind(kind)
					return modified_priority[kind] or kind
				end

				local kind1 = modified_kind(entry1:get_kind())
				local kind2 = modified_kind(entry2:get_kind())
				if kind1 ~= kind2 then
					return kind1 - kind2 < 0
				end
			end,
		}
	}
}

cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' },
	}
})
