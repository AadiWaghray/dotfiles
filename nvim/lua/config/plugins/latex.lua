return {
	{
		'lervag/vimtex',
		ft = "tex",
		init = function()
			vim.g.vimtex_view_method = 'skim'
			vim.g.vimtex_complete_enable = 1
			vim.g.vimtex_view_skim_sync = 1
		end,
	},
}
