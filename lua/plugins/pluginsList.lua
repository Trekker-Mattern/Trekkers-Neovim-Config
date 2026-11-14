local plugins = {

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			-- Disable entire built-in ftplugin mappings to avoid conflicts.
			-- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
		vim.g.no_plugin_maps = true

			-- Or, disable per filetype (add as you like)
			-- vim.g.no_python_maps = true
			-- vim.g.no_ruby_maps = true
			-- vim.g.no_rust_maps = true
			-- vim.g.no_go_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup {	
			-- put your config here
				select = {
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			-- You can choose the select mode (default is charwise 'v')
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * method: eg 'v' or 'o'
			-- and should return the mode ('v', 'V', or '<c-v>') or a table
			-- mapping query_strings to modes.
			selection_modes = {
			  ['@parameter.outer'] = 'v', -- charwise
			  ['@function.outer'] = 'V', -- linewise
			  -- ['@class.outer'] = '<c-v>', -- blockwise
			},
			-- If you set this to `true` (default is `false`) then any textobject is
			-- extended to include preceding or succeeding whitespace. Succeeding
			-- whitespace has priority in order to act similarly to eg the built-in
			-- `ap`.
			--
			-- Can also be a function which gets passed a table with the keys
			-- * query_string: eg '@function.inner'
			-- * selection_mode: eg 'v'
			-- and should return true of false
			include_surrounding_whitespace = false,
		  },
		}

		-- keymaps
		-- You can use the capture groups defined in `textobjects.scm`
		vim.keymap.set({ "x", "o" }, "am", function()
		  require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "im", function()
		  require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ac", function()
		  require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
		end)
		vim.keymap.set({ "x", "o" }, "ic", function()
		  require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
		end)
		-- You can also use captures from other query groups like `locals.scm`
		vim.keymap.set({ "x", "o" }, "as", function()
		  require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
		end)
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {}
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	--{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
	{'nvim-telescope/telescope.nvim', version = '*',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		}
	},
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.config').setup({
				highlight = {enable = true },
				indent = {enable = true},
			})
		end

	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"saifulapm/neotree-file-nesting-config",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons", -- optional, but recommended
		},
		lazy = false, -- neo-tree will lazily load itself
		opts = {
			hide_root_node = true,
			retain_hidden_root_indent = true,
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					show_hidden_count = false,
					never_show = {'.DS_Store',},
				}
			}
		},
		default_component_configs = {
        indent = {
          with_expanders = true,
          expander_collapsed = '',
          expander_expanded = '',
        },
      },
	  config = function(_, opts)
     	 -- Adding rules from plugin
     	 opts.nesting_rules = require('neotree-file-nesting-config').nesting_rules
     	 require('neo-tree').setup(opts)
      end
	},
	{
	  'saghen/blink.cmp',
		  -- optional: provides snippets for the snippet source
		  dependencies = { 'rafamadriz/friendly-snippets' },

		  version = '1.*',
			  ---@module 'blink.cmp'
			  ---@type blink.cmp.Config
			  opts = {
				-- 'super-tab' for mappings similar to vscode (tab to accept)
				-- All presets have the following mappings:
				-- C-space: Open menu or open docs if already open
				-- C-e: Hide menu
				-- C-k: Toggle signature help (if signature.enabled = true)
				-- See :h blink-cmp-config-keymap for defining your own keymap
				keymap = { preset = 'super-tab' },
				appearance = {
				  -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				  -- Adjusts spacing to ensure icons are aligned
				  nerd_font_variant = 'Nerd Font'
				},
				completion = { documentation = { auto_show = false } },

				sources = {
				  default = { 'lsp', 'path', 'snippets', 'buffer' },
				},

		fuzzy = { implementation = "prefer_rust_with_warning" }
	  },
	  opts_extend = { "sources.default" }
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
			  "<leader>xx",
			  "<cmd>Trouble diagnostics toggle<cr>",
			  desc = "Diagnostics (Trouble)",
			},
			{
			  "<leader>xX",
			  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			  desc = "Buffer Diagnostics (Trouble)",
			},
			{
			  "<leader>cs",
			  "<cmd>Trouble symbols toggle focus=false<cr>",
			  desc = "Symbols (Trouble)",
			},
			{
			  "<leader>cl",
			  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			  desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
			  "<leader>xL",
			  "<cmd>Trouble loclist toggle<cr>",
			  desc = "Location List (Trouble)",
			},
			{
			  "<leader>xQ",
			  "<cmd>Trouble qflist toggle<cr>",
			  desc = "Quickfix List (Trouble)",
			},
		},
	},
}

return plugins
