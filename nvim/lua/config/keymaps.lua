local M = {}

M.movement = {
	{{"v"}, "[e", ":m '<-2<CR>gv=gv", {}},
	{{"v"}, "]e", ":m '<+1<CR>gv=gv", {}},
	{{"n"}, "<C-d>", "<C-d>zz", {}},
	{{"n"}, "<C-u>", "<C-u>zz", {}},
	{{"n"}, "n", "nzz", {}},
	{{"n"}, "N", "Nzz", {}},
}

M.autocomplete = {
}
--Movement
vim.keymap.set("v", "[e", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "]e", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

--Auto-complete
local cmp = require'cmp'
vim.keymap.set("i", "<CR>", cmp.mapping.confirm({ select = true }), {})
vim.keymap.set("i", "<C-j>", cmp.mapping.select_next_item(), {})
vim.keymap.set("i", "<C-k>", cmp.mapping.select_prev_item(), {})
vim.keymap.set("i", "<C-h>", cmp.mapping.scroll_docs(4), {})
vim.keymap.set("i", "<C-l>", cmp.mapping.scroll_docs(-4), {})

--Diagnostic
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {buffer=0})
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {buffer=0})
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setqflist, {buffer=0})
vim.keymap.set('n', '<leader>dt', '<cmd>Telescope diagnostics<cr>', {buffer=0})

--Debug
vim.keymap.set('n', '<space>c', function() require('dap').continue() end)
vim.keymap.set('n', '<space>so', function() require('dap').step_over() end)
vim.keymap.set('n', '<space>si', function() require('dap').step_into() end)
vim.keymap.set('n', '<leader>so', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<leader>dh', function()
	require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<leader>dp', function()
	require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end)

--Telescope
local builtin = require("telescope.builtin")
local action = require("telescope.actions")
local action_state = require("telescope.actions.state")
local cp = require("config.telescope.custom_picker")
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.find_files {
		attach_mappings = function(_, map)
			map("i", "<CR>", function(_promprt_bfnr)
				local file_path = action_state.get_selected_entry()[1]
				action.close(_promprt_bfnr)
				vim.cmd.source(vim.fs.joinpath(vim.fs.joinpath(vim.fn.stdpath("config"), "sessions"), file_path))
			end)

			return true
		end,
		cwd = vim.fs.joinpath(vim.fn.stdpath("config"), "sessions")
	}
end, {})

vim.keymap.set('n', '<leader>fp', function()
	builtin.find_files {
		cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
	}
end, {})
vim.keymap.set('n', '<leader>fd', function() builtin.lsp_document_symbols({ symbols = { 'function', 'variable' }}) end, {})

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>s", function()
	local session_name = vim.fn.input("Name of Session: ")
	vim.cmd("mks "..vim.fs.joinpath(vim.fs.joinpath(vim.fn.stdpath("config"), "sessions"), session_name))
end)
