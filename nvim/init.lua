require("lazy").setup({
	-- Telescope
	'nvim-telescope/telescope.nvim',
	-- Core Functionality
	'nvim-lua/plenary.nvim',
	'neovim/nvim-lspconfig', -- Helps manage and connect to different LS
	-- VimWiki
	{
		'vimwiki/vimwiki',
		init = function()
			vim.g.vimwiki_list = {{path = '~/vimwiki/', syntax = 'markdown', ext = '.md'}}
			vim.g.vimwiki_global_ext = 0
			--vim.g.vimwiki_option_auto_tags = {{path: '~/vimwiki/', auto_tags: 0}}
			--vim.g.vimwiki_tag_format = {{pre: '\(^[ -]*tags\s*: .*\)\@<=', pre_mark: '@', post_mark: '', sep: '>><<'}}
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
	-- Fuzzy Finder
	'nvim-telescope/telescope.nvim',
	'lewis6991/gitsigns.nvim',
	-- Latex
	{
		'lervag/vimtex',
		init = function()
			vim.g.vimtex_view_method = 'skim'
			vim.g.vimtex_complete_enable = 1
			vim.g.vimtex_view_skim_sync = 1
		end,
	},
	-- Browse
	{
		'lalitmee/browse.nvim',
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	-- Snippets
	'L3MON4D3/LuaSnip',
	-- Color Themes
	'Mofiqul/dracula.nvim',
	'EdenEast/nightfox.nvim',
	'folke/tokyonight.nvim',
	-- Treesitter
	'nvim-treesitter/nvim-treesitter',
	-- Linter
	'mfussenegger/nvim-lint',
	-- Obsidian
	-- 'epwalsh/obsidian.nvim'
	-- Auto Completion
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	-- TODO: Make sure these can be removed
	'SirVer/ultisnips',
	'quangnguyen30192/cmp-nvim-ultisnips',
	-- Git Wrapper
	'tpope/vim-fugitive',
})

-- Default Settings
vim.g.mapleader = '\\'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.mouse = a
vim.opt.autoindent = true
vim.opt.relativenumber = true
vim.opt.hidden = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.conceallevel = 2

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
local LSP_Server_List = {'pylsp', 'jdtls', 'texlab', 'clangd', 'tsserver'}
-- Set up lspconfig.
vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, {buffer=0})
vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, {buffer=0})
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

require('lspconfig').rust_analyzer.setup {
	-- Server-specific settings. See `:help lspconfig-setup`
    capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		['rust-analyzer'] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
}

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript"},

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

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
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
}

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

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

require('gitsigns').setup {
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
    yadm = {
		enable = false
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
		map('n', '<leader>hS', gs.stage_buffer)
		map('n', '<leader>hu', gs.undo_stage_hunk)
		map('n', '<leader>hR', gs.reset_buffer)
		map('n', '<leader>hp', gs.preview_hunk)
		map('n', '<leader>hb', function() gs.blame_line{full=true} end)
		map('n', '<leader>tb', gs.toggle_current_line_blame)
		map('n', '<leader>hd', gs.diffthis)
		map('n', '<leader>hD', function() gs.diffthis('~') end)
		map('n', '<leader>td', gs.toggle_deleted)

		-- Text object
		map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  	end
}


require('lint').linters_by_ft = {
	markdown = {'vale',},
	python = {'pylint',},
	javascript = {'eslint',},
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
