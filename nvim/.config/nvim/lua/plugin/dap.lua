require("dapui").setup()
require("nvim-dap-virtual-text").setup({
	highlight_changed_variables = true
})

local dap, dapui = require('dap'), require('dapui')

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

vim.keymap.set("n", "<Leader>dc", dap.continue, { silent = true })
vim.keymap.set("n", "<Leader>dj", dap.step_over, { silent = true })
vim.keymap.set("n", "<Leader>dl", dap.step_into, { silent = true })
vim.keymap.set("n", "<Leader>dk", dap.step_out, { silent = true })
vim.keymap.set("n", "<Leader>dgc", dap.run_to_cursor, { silent = true })
vim.keymap.set("n", "<Leader>dbp", dap.toggle_breakpoint, { silent = true })
vim.keymap.set("n", "<Leader>dr", dap.repl.open, { silent = true })
vim.keymap.set("n", "<Leader>di", dapui.eval, { silent = true })
vim.keymap.set("v", "<Leader>di", dapui.eval, { silent = true })
vim.keymap.set("n", "<Leader>de", dap.terminate, { silent = true })

vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermfg = 52 })
vim.api.nvim_set_hl(0, "DapStopped", { ctermfg = 22, ctermbg = 7 })
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })

vim.api.nvim_create_user_command("DAPClearBreakpoints", function() dap.clear_breakpoints() end, {})

dap.adapters.lldb = {
	type = 'executable',
	command = '/usr/bin/lldb-vscode',
	name = 'lldb'
}

dap.configurations.rust = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			local components = vim.split(vim.fn.getcwd(), "/")
			return vim.fn.getcwd() .. "/target/debug/" .. components[#components]
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},
	},
	{
		name = 'Launch (manual)',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = function()
			local input = vim.fn.input("args: ")
			local args = {}
			for word in string.gmatch(input, "%w+") do
				table.insert(args, word)
			end
			return args
		end,
	}
}

vim.api.nvim_create_user_command("DapScope", function()
	local widgets = require "dap.ui.widgets";
	widgets.centered_float(widgets.scopes)
end, {})

vim.api.nvim_create_user_command("DapHover", function()
	require "dap.ui.widgets".hover()
end, {})

require('dap-go').setup {
	delve = {
		port = "38697"
	},
	dap_configurations = {
		{
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		}
	}
}

require("dap-python").setup("python3")
