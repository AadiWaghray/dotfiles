return {
	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ":TSUpdate",
		opts = {
			ensure_installed = { "c", "lua", "go", "asm", "vim", "markdown", "query", "python", "javascript"},
			auto_install = false,
			ignore_install = { "latex" },
			highlight = {
				enable = true,
				-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
				disable = function(lang, buf)
					if lang == "latex" or lang == "rust" then return true end

					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return true
					end

					return false
				end,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
			textobjects = {
				move = {
					enable = true,
					set_jumps = false,
					goto_next_start = {
						["]c"] = { query = "@code_cell.inner", desc = "next code block" },
					},
					goto_previous_start = {
						["[c"] = { query = "@code_cell.inner", desc = "previous code block" },
					},
				},
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ic"] = { query = "@code_cell.inner", desc = "in block" },
						["ac"] = { query = "@code_cell.outer", desc = "around block" },
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["<leader>sbl"] = "@code_cell.outer",
					},
					swap_previous = {
						["<leader>sbh"] = "@code_cell.outer",
					},
				},
			}
		}
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
}
