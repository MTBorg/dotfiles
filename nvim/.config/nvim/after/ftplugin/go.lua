local gopher = require("gopher")
vim.api.nvim_create_user_command("GoTagsAddJsonCC", function() gopher.tags.add("json", "-transform", "camelcase") end,
	{ desc = "Add json tags (camelcase)" })
vim.api.nvim_create_user_command("GoTagsAddJsonSC", function() gopher.tags.add("json", "-transform", "snakecase") end,
	{ desc = "Add json tags (snakecase)" })
