-- Some formatters bundled with the LSPs don't work well or are difficult to get working.
-- Conform works better for them in some cases; prefer builtin formatters though.
-- Remember to ignore the formatters in the LSPs if you use Conform.
require("conform").setup({
	formatters_by_ft = {
		vue = { "prettierd", "prettier", stop_after_first = true },
	},
})
