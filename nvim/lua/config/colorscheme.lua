local M = {}

M.tokyonight = function()
	vim.cmd.colorscheme('tokyonight')
end

M.gotham = function()
	vim.cmd.colorscheme('gotham')
end

M.kanagawa = function()
	vim.cmd.colorscheme('kanagawa-dragon')
end

M.nightfox = function()
	vim.cmd.colorscheme('nightfox')
end

M.dracula = function()
	vim.cmd.colorscheme('dracula-soft')
end

M.transparent = function()
	vim.api.nvim_set_hl(0, "Normal", { guibg=NONE, ctermbg=NONE })
	vim.api.nvim_set_hl(0, "NormalNC", { guibg=NONE, ctermbg=NONE })
	vim.api.nvim_set_hl(0, "LineNr", { guibg=NONE, ctermbg=NONE })
	vim.api.nvim_set_hl(0, "SignColumn", { guibg=NONE, ctermbg=NONE })

	--TOOD: This would be better set per colorscheme? Or have default
	--vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='gray', bold=true })
	--vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
	--vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='gray', bold=true })
end

return M
