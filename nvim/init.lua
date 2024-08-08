local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
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
		opts = function() 
			local builtin = require('telescope.builtin')

			return {
				defaults = {
					mappings = {
						i = {
							["<C-h>"] = "which_key",
							["<leader>ff"] = builtin.find_files,
							["<leader>ffg"] = builtin.live_grep,
							["<leader>ffb"] = builtin.buffers,
							["<leader>ffh"] = builtin.help_tags,
							["<leader>ffm"] = builtin.marks,
							["<leader>ffq"] = builtin.quickfix,
							["<leader>ffm"] = builtin.man_pages,

							["<leader>gb"] = builtin.git_branches,
							["<leader>gs"] = builtin.git_status,
						}
					}
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
	-- Core Functionality
	{
		'nvim-lua/plenary.nvim', --Check later 
		lazy = true
	},
	--[[
	{
		'mfussenegger/nvim-jdtls', --Check later
		lazy = true,
	},
	--]]
	'neovim/nvim-lspconfig',
	--[[
	'edluffy/hologram.nvim',--Check later
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		build = ":UpdateRemotePlugins",
		init = function()
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = false
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true

			vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>",{ silent = true, desc = "Initialize the plugin" })
			vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>",{ silent = true, desc = "run operator selection" })
			vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>",{ silent = true, desc = "evaluate line" })
			vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>",{ silent = true, desc = "re-evaluate cell" })
			vim.keymap.set("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv",{ silent = true, desc = "evaluate visual selection" })
			vim.keymap.set("n", "<localleader>ri", ":MoltenInterrupt<CR>",{ silent = true, desc = "" })
			vim.keymap.set("n", "<localleader>ro", ":MoltenOpenInBrowser<CR>",{ silent = true, desc = "" })
			vim.keymap.set("n", "<localleader>re", ":noautocmd MoltenEnterOutput<CR>",{ silent = true, desc = "" })
			vim.keymap.set("n", "<localleader>rh", ":MoltenHideOutput<CR>",{ silent = true, desc = "" })
		end,
	},
	{
		"GCBallesteros/jupytext.nvim",
		config = true,
		-- Depending on your nvim distro or config you may need to make the loading not lazy
		-- lazy=false,
	},
	--]]
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true, -- or `opts = {}`
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
	-- Lualine
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		init = function()
			require('lualine').setup()
		end,
	},
	-- Inline Latex
	{
		'jbyuki/nabla.nvim',
		ft = {"markdown", "latex"},
		init = function()
			vim.keymap.set('n', '<leader>pd', require("nabla").disable_virt, {buffer=0})
			vim.keymap.set('n', '<leader>pe', require("nabla").enable_virt, {buffer=0})
			vim.api.nvim_create_autocmd('InsertLeave', {
				group = vimwiki,
				pattern = '~/vimwiki/.*/*.md',
				callback = require("nabla").enable_virt
			})
			vim.api.nvim_create_autocmd('InsertEnter', {
				group = vimwiki,
				pattern = '~/vimwiki/.*/*.md',
				callback = require("nabla").disable_virt
			})
		end,	
	},
	{
		'lewis6991/gitsigns.nvim',
		--TODO: Move setup to here
	},
	{
		'lervag/vimtex',
		ft = "tex",
		init = function()
			vim.g.vimtex_view_method = 'skim'
			vim.g.vimtex_complete_enable = 1
			vim.g.vimtex_view_skim_sync = 1
		end,
	},
	--[[
	{
		'lalitmee/browse.nvim',
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	--]]
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp"
	},
	-- Color Themes
	'Mofiqul/dracula.nvim',
	'EdenEast/nightfox.nvim',
	'folke/tokyonight.nvim',
	-- Treesitter
	'nvim-treesitter/nvim-treesitter',
	'nvim-treesitter/nvim-treesitter-textobjects',
	-- Auto Completion
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	{
		'tpope/vim-fugitive',
	},
})

-- Default Settings
vim.g.mapleader = '\\'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.mouse = a
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.conceallevel = 2

-- KeyMaps
vim.keymap.set("v", "[e", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "]e", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)

local ls = require("luasnip")
vim.keymap.set({"i"}, "<C-Space>", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-_>", function() ls.jump(1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<C-\\>", function() ls.jump(-1) end, {silent = true})
vim.keymap.set("n", "<leader>s", "<cmd>source ~/.config/nvim/after/plugin/luasnip.lua<CR>", {silent = true})

vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, {silent = true})

-- ColorScheme
vim.cmd 'colorscheme tokyonight'
--vim.cmd 'colorscheme nightfox'
--vim.cmd 'colorscheme dracula-soft'


local file_creation = vim.api.nvim_create_augroup("SKELETON", {clear = true})
vim.api.nvim_create_autocmd({"BufNewFile"}, {
  group = file_creation,
  pattern  = "hw_*.tex",
  command = '0r ~/.config/nvim/templates/hw_tex.tex'
})
vim.api.nvim_create_autocmd({"BufNewFile"}, {
  group = file_creation,
  pattern  = "hw_*.py",
  command = '0r ~/.config/nvim/templates/hw_py.py'
})
vim.api.nvim_create_autocmd({"BufNewFile"}, {
  group = file_creation,
  pattern  = "~/vimwiki/*.md",
  command = '0r ~/.config/nvim/templates/vimwiki.md'
})


local cmp = require'cmp'
cmp.setup({
    snippet = {
      expand = function(args)
	  	require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
    	['<C-j>'] = cmp.mapping.select_next_item(),
    	['<C-k>'] = cmp.mapping.select_prev_item(),
    	['<C-b>'] = cmp.mapping.scroll_docs(-4),
    	['<C-f>'] = cmp.mapping.scroll_docs(4),
    	-- ['<C-Space>'] = cmp.mapping.complete(),
    	['<C-e>'] = cmp.mapping.abort(),
    	['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
		{ name = 'otter' },
		{ name = 'nvim_lsp' },
    	{ name = 'luasnip' },
      	--{ name = 'ultisnips' },
		}, {
		{ name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      	{ name = 'buffer' }
    }
})	

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local LSP_Server_List = {'pyright', 'jdtls', 'texlab', 'clangd', 'sqlls', 'tsserver'}
-- Set up lspconfig.
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {buffer=0})
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {buffer=0})
vim.keymap.set('n', '<leader>dt', '<cmd>Telescope diagnostics<cr>', {buffer=0})


local on_attach = function(client, bufnr)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {buffer=0})
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {buffer=0})
	vim.keymap.set('n', '<leader>fb', vim.lsp.buf.format, {buffer=0})
	vim.keymap.set('n', '<leader>m', vim.lsp.buf.implementation(), {buffer=0})
	vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition(), {buffer=0})
	require'completion'.on_attach(client)
	vim.lsp.inlay_hint.enable(bufnr)
end

for _, LSP in ipairs(LSP_Server_List) do
	require('lspconfig')[LSP].setup{
    	capabilities = capabilities,
		on_attach = on_attach,
	}
end

require('lspconfig').gopls.setup({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

require('lspconfig').rust_analyzer.setup {
	-- Server-specific settings. See `:help lspconfig-setup`
    --capabilities = capabilities,
	on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
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
}

--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "go", "asm", "vim", "markdown", "query", "python", "javascript"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  -- auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "latex"},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- list of language that will be disabled
    disable = {"latex", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
	  enable = true,
  },
	 textobjects = {
        move = {
            enable = true,
            set_jumps = false, -- you can change this if you want.
            goto_next_start = {
                --- ... other keymaps
                ["]c"] = { query = "@code_cell.inner", desc = "next code block" },
            },
            goto_previous_start = {
                --- ... other keymaps
                ["[c"] = { query = "@code_cell.inner", desc = "previous code block" },
            },
        },
        select = {
            enable = true,
            lookahead = true, -- you can change this if you want
            keymaps = {
                --- ... other keymaps
                ["ic"] = { query = "@code_cell.inner", desc = "in block" },
                ["ac"] = { query = "@code_cell.outer", desc = "around block" },
            },
        },
        swap = { -- Swap only works with code blocks that are under the same
                 -- markdown header
            enable = true,
            swap_next = {
                --- ... other keymap
                ["<leader>sbl"] = "@code_cell.outer",
            },
            swap_previous = {
                --- ... other keymap
                ["<leader>sbh"] = "@code_cell.outer",
            },
        },
    }
}

--[[
require('browse').setup({
  provider = "google", -- duckduckgo, bing

  bookmarks = {},
  icons = {
      bookmark_alias = "",
      bookmarks_prompt = "", -- if you have nerd fonts, you can set this to "󰂺 "
      grouped_bookmarks = "",
  }
})

function command(name, rhs, opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(name, rhs, opts)
end

local browse = require('browse')

command("InputSearch", function()
  browse.input_search()
end, {})

-- this will open telescope using dropdown theme with all the available options
-- in which `browse.nvim` can be used
command("Browse", function()
  browse.browse({ bookmarks = bookmarks })
end)

command("Bookmarks", function()
  browse.open_bookmarks({ bookmarks = bookmarks })
end)

command("DevdocsSearch", function()
  browse.devdocs.search()
end)

command("DevdocsFiletypeSearch", function()
  browse.devdocs.search_with_filetype()
end)

command("MdnSearch", function()
  browse.mdn.search()
end)
--]]
--
require('gitsigns').setup {--TODO: Move to lazy
    signs = {
	add          = { text = '│' },
	change       = { text = '│' },
	delete       = { text = '_' },
	topdelete    = { text = '‾' },
	changedelete = { text = '~' },
	untracked    = { text = '┆' },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
	follow_files = true
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
	virt_text = true,
	virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
	delay = 1000,
	ignore_whitespace = false,
	virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
	-- Options passed to nvim_open_win
	border = 'single',
	style = 'minimal',
	relative = 'cursor',
	row = 0,
	col = 1
    },
  	on_attach = function(bufnr)
    	local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map('n', ']c', function()
			if vim.wo.diff then return ']c' end
		  	vim.schedule(function() gs.next_hunk() end)
		  	return '<Ignore>'
		end, {expr=true})

		map('n', '[c', function()
		  	if vim.wo.diff then return '[c' end
		  	vim.schedule(function() gs.prev_hunk() end)
		  	return '<Ignore>'
		end, {expr=true})

		-- Actions
		map('n', '<leader>hs', gs.stage_hunk)
		map('n', '<leader>hr', gs.reset_hunk)
		map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
		map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
		map('n', '<leader>bs', gs.stage_buffer)
		map('n', '<leader>hu', gs.undo_stage_hunk)
		map('n', '<leader>br', gs.reset_buffer)
		map('n', '<leader>hp', gs.preview_hunk)
		map('n', '<leader>lb', function() gs.blame_line{full=true} end)
		map('n', '<leader>tb', gs.toggle_current_line_blame)
		map('n', '<leader>hd', gs.diffthis)
		map('n', '<leader>hD', function() gs.diffthis('~') end)
		map('n', '<leader>td', gs.toggle_deleted)

		-- Text object
		map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  	end
}


--vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--	callback = function()
--		require("lint").try_lint()
--	end,
--})
require('lualine').setup {
	options = {
    	icons_enabled = true,
    	theme = 'auto',
    	component_separators = { left = '', right = ''},
    	section_separators = { left = '', right = ''},
    	disabled_filetypes = {
			statusline = {},
			winbar = {},
    	},
    	ignore_focus = {},
    	always_divide_middle = true,
    	globalstatus = false,
    	refresh = {
      	statusline = 1000,
      	tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = {'mode'},
		lualine_b = {'branch', 'diff', 'diagnostics'},
		lualine_c = {'filename'},
		lualine_x = {'encoding', 'fileformat', 'filetype'},
		lualine_y = {'progress'},
		lualine_z = {'location'}
  	},
  	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {'filename'},
		lualine_x = {'location'},
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}

require("headlines").setup {
    markdown = {
        query = vim.treesitter.query.parse(
            "markdown",
            [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
        ),
        headline_highlights = { "Headline" },
        bullet_highlights = {
            "@text.title.1.marker.markdown",
            "@text.title.2.marker.markdown",
            "@text.title.3.marker.markdown",
            "@text.title.4.marker.markdown",
            "@text.title.5.marker.markdown",
            "@text.title.6.marker.markdown",
        },
        bullets = { "◉", "○", "✸", "✿" },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        dash_string = "-",
        quote_highlight = "Quote",
        quote_string = "┃",
        fat_headlines = true,
        fat_headline_upper_string = "▃",
        fat_headline_lower_string = "🬂",
    },
}

vim.diagnostic.config({
    virtual_text = false,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})

--[[
local config = {
    cmd = {'~/.config/nvim/jdt-language-server-latest/bin/jdtls'},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
}
--]]

--[[
require('hologram').setup{
    auto_display = true -- WIP automatic markdown image display, may be prone to breaking
}

require("jupytext").setup({
    style = "markdown",
    output_extension = "md",
    force_ft = "markdown",
})
--]]
