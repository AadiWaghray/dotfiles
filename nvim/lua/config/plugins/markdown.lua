return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			heading = { 
				position = 'inline',
				width = 'block',
			},
		}
	},
	-- Wiki
	{
		'lervag/wiki.vim',
		init = function()
			vim.g.wiki_root = '~/Documents/Vault'
		end,
	},
	-- Otter: embbeded highlighting
	{
		'jmbuhr/otter.nvim',
		dependencies = {
			'hrsh7th/nvim-cmp', -- optional, for completion
			'neovim/nvim-lspconfig',
			'nvim-treesitter/nvim-treesitter'
		}
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
		build = function() vim.fn["mkdp#util#install"]() end,
		init = function()
			vim.g.mkdp_theme = 'light'
			vim.cmd("nmap <leader>mdo <Plug>MarkdownPreview")
			vim.cmd("nmap <leader>mds <Plug>MarkdownPreviewStop")
			vim.cmd("nmap <leader>md <Plug>MarkdownPreviewToggle")
			vim.cmd(
			[[
			function OpenMarkdownPreview (url)
				execute "silent ! open -na 'Google Chrome' --args --new-window " . a:url
				endfunction
				]]
				)
				vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
			end,

		},
	}
