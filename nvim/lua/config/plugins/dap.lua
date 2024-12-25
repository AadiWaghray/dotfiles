return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require('dap')
			dap.configurations = {
				c = {
					{
						name = "Launch",
						type = "codelldb",
						request = "launch",
						program = function()
							return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
						end,
					},
				}
			}
		end
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			--local dap, dapui = require("dap"), require("dapui")
			--dap.listeners.before.attach.dapui_config = function()
			--	dapui.open()
			--end
			--dap.listeners.before.launch.dapui_config = function()
			--	dapui.open()
			--end
			--dap.listeners.before.event_terminated.dapui_config = function()
			--	dapui.close()
			--end
			--dap.listeners.before.event_exited.dapui_config = function()
			--	dapui.close()
			--end
		end
	},
}
