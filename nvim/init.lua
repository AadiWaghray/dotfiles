require("config.lazy")

-- Keymaps
require("config.keymaps")

-- ColorScheme
local colorscheme = require("config.colorscheme")
colorscheme.tokyonight()
colorscheme.transparent()

-- Autocommands
local file_creation = vim.api.nvim_create_augroup("SKELETON", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group   = file_creation,
	pattern = "hw_*.tex",
	command = '0r ~/.config/nvim/templates/hw_tex.tex'
})
vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	group   = file_creation,
	pattern = "hw_*.py",
	command = '0r ~/.config/nvim/templates/hw_py.py'
})
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	callback = function(args)
		local buf = vim.api.nvim_create_buf(false, true);

		local width = math.floor(vim.o.columns * 0.7);
		local height = math.floor(vim.o.lines * 0.7)

		local col = math.floor((vim.o.columns - width) / 2);
		local row = math.floor((vim.o.lines - height) / 2);

		local win = vim.api.nvim_open_win(buf, true, {
			height=height,
			width=width,
			row=row,
			col=col,
			relative="editor",
			border="rounded",
			title="Terminal",
			title_pos="center",
			noautocmd=true,
		})

		vim.cmd.terminal()
		vim.api.nvim_win_close(win, true)

		vim.keymap.set("n", "<space>t", function()
			vim.api.nvim_open_win(buf, true, {
				height=height,
				width=width,
				row=row,
				col=col,
				relative="editor",
				style="minimal",
				border="rounded",
				title="Terminal",
				title_pos="center",
				noautocmd=true,
			})
			vim.cmd.startinsert()
		end)
	end
})
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})
--TODO: change keymaps to a table and have it so that this section can run on table so definitions local and can be applied where needed
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client == nil or client == '' then return end

		if client.supports_method('textDocument/hover') then
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = 0 })
		end
		if client.supports_method('textDocument/definition') then
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = 0 })
		end
		if client.supports_method('textDocument/codeAction') then
			vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = 0 })
		end
		if client.supports_method('textDocument/implementation') then
			vim.keymap.set('n', '<leader>m', vim.lsp.buf.implementation, { buffer = 0 })
		end
		if client.supports_method('textDocument/typeDefinition*') then
			vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, { buffer = 0 })
		end
		if client.supports_method('textDocument/rename') then
			vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = 0 })
		end
		if client.supports_method('textDocument/format') then
			vim.api.nvim_create_autocmd('BufWrite', {
				buffer=0,
				callback=vim.lsp.buf.format,
			})
		end
	end,
})

local lspconfig = require 'lspconfig'
lspconfig.pyright.setup {}
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' }
			}
		}
	}
})
lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true
			},
		}
	}
})
require 'lspconfig'.clangd.setup {}

vim.diagnostic.config({
	virtual_text = false
})
