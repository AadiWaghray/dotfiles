return {
	-- Telescope
	{
		'nvim-telescope/telescope.nvim', --TODO: Checkout types of pickers and previewers and layout/ theme GOD so much documentation
			tag = "0.1.8",
				branch = "0.1.x",
				dependencies = {
					"nvim-lua/plenary.nvim",
					"BurntSushi/ripgrep",
					"nvim-telescope/telescope-fzf-native.nvim",
					"nvim-treesitter/nvim-treesitter",
					"neovim/nvim-lspconfig",
					"nvim-tree/nvim-web-devicons",
				},
				keys = function()
					local builtin = require('telescope.builtin')
					local telescope = require('telescope')

					return {
						{
							"<C-h>",
							function()
								require("telescope.actions").which_key()
								end
						},
						{
							"<leader>ff",
							function()
								builtin.find_files()
								end
						},
						{
							"<leader>fg",
							function()
								builtin.live_grep()
								end
						},
						{
							"<leader>buf",
							function()
								builtin.buffers()
								end
						},
						{
							"<leader>fh",
							function()
								builtin.help_tags()
								end
						},
						{
							"<leader>fm",
							function()
								builtin.marks()
								end
						},
						{
							"<leader>fgb",
							function()
								builtin.git_branch()
								end
						},
						{
							"<leader>fgs",
							function()
								builtin.git_status()
								end
						}

					}
		end,
			opts = function() 
				local builtin = require('telescope.builtin')

				return {
					defaults = {
					},
					pickers = {
						-- picker_name = {
							--   picker_config_key = value,
							--   ...
								-- }
					},
					extensions = {
						-- extension_name = {
							--   extension_config_key = value,
							-- }
						-- telescope-frecency.nvim
							-- telescope-zotero.nvim
							-- telescope-dap.nvim
							-- telescope-zoxide
					}
				}
		end
			,
	},
}
