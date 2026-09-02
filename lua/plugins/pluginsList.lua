local plugins = {

	--{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
	{'Mofiqul/vscode.nvim', name = "vscode", lazy=false, priority = 1000},
	{'nvim-telescope/telescope.nvim', version = '*',
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
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"}
	},
}

return plugins
