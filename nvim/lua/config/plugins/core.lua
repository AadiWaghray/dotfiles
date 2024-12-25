return {
	-- Core Functionality
	{
		'nvim-lua/plenary.nvim', --Check later 
		lazy = true
	},
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp"
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		'tpope/vim-fugitive',
	},
}
