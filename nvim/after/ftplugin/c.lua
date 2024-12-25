vim.api.nvim_buf_set_keymap(0, "n", "<C-x>", ":! make", {})

local dap = require('dap')
dap.adapters.codelldb = {
	type = 'server',
	port = "${port}",
	executable = {
		command = vim.fn.expand('/Users/aadiwaghray/.config/nvim/extension/adapter/codelldb'),
		args = {"--port", "${port}"},
	}
}
