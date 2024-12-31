local ls = require("luasnip")
ls.setup({})
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

ls.add_snippets("go", {
	s("struct", fmt([[
	type {} struct {{
		{}
	}}
	]], { i(1, "Name"), i(2) })),

	s("interface", fmt([[
	type {} interface {{
		{}
	}}
	]], { i(1, "Name"), i(2) })),

	s("pkgmain", fmt([[
	package main

	import (
		"fmt"
	)

	func main() {{
		{}
	}}
	]], { i(1) })),

	s("import", fmt([[
	import (
		{}
	)
	]], { i(1) })),

	s("iferr", fmt([[
	if err != nil {{
		{}
	}}
	]], { i(1) })),

	s("iferr2", fmt([[
	if err := {}; err != nil {{
		{}
	}}
	]], { i(1), i(2) })),

	s("returnerr", fmt([[
	return fmt.Errorf("{}: %w", err)
	]], { i(1) })),

	s("jsonm", fmt([[
	d, err := json.Marshal({})
	if err != nil {{
		{}
	}}
	]], { i(1), i(2) })),

	s(
		"jsonu",
		fmt([[
		var {} {}
		err := json.Unmarshal(&{})
		if err != nil {{
			{}
		}}
	]], { i(1), i(2), rep(1), i(3) })
	),

	s(
		"slogerrc",
		fmt([[
			slog.ErrorContext(ctx, "{}", slog.String("error", err.Error))
		]], { i(1) })
	),

	s(
		"ctxb",
		fmt([[
			ctx := context.Background()
		]], {})
	),

	s(
		"varblock",
		fmt([[
			var (
				{}
			)
		]], { i(1) })
	)
})

ls.add_snippets("proto",
	{
		s("endpoint",
			fmt([[
				rpc {}({}Request) returns ({}Response)
			]], { i(1), rep(1), rep(1) }
			)
		),

		s("message",
			fmt([[
			message {}{{
				{}
			}}
			]], { i(1, "Name"), i(2) }
			)
		)
	}
)
