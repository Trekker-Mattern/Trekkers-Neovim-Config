vim.g.mapleader = " "    			   --Fun Leading Character (SPACE)
vim.opt.tabstop = 4      			   --Number of spaces in a tab
vim.opt.shiftwidth = 4   			   --Number of spaces for auto-tab
vim.opt.number = true     		    	 --Display Line Numbers
vim.opt.relativenumber = true 		     --Display relative Line Numbers
vim.opt.filetype = "on" 				 --FileName Hilighting
vim.opt.smartindent = true               --Does Smart Indenting after hitting enter (gg=G to indent whole file)
vim.g.maplocalleader = "\\"

filetoggle = false
vim.keymap.set('n', '<A-k>', ':m .+1<CR>==zv', {noremap = true, silent = true})
vim.keymap.set('n', '<A-j>', ':m .-2<CR>==zv', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>h', ':lua vim.diagnostic.open_float()<enter>' ,{noremap = true, silent = true})
vim.keymap.set('n', '<C-s>', ':wa<enter>', {noremap = true, silent = false})
vim.keymap.set('n', '<leader>saq', ':wa<enter>:q<enter>', {noremap = true, silent = false})


if filetoggle then
	vim.keymap.set('n', '<leader>n', ':Neotree filesystem quit <CR>')
	filetoggle = false 
else 
	vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left <CR>')
	filetoggle = true
end

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

--LazyVim Setup

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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
--[[
local plugins = {

	-- add your plugins here
	{ "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
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

		  -- use a release tag to download pre-built binaries
		  version = '1.*',
		  -- AND/OR build from source
		  -- build = 'cargo build --release',
		  -- If you use nix, you can build from source with:
		  -- build = 'nix run .#build-plugin',

			  ---@module 'blink.cmp'
			  ---@type blink.cmp.Config
			  opts = {
				-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
				-- 'super-tab' for mappings similar to vscode (tab to accept)
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- All presets have the following mappings:
				-- C-space: Open menu or open docs if already open
				-- C-n/C-p or Up/Down: Select next/previous item
				-- C-e: Hide menu
				-- C-k: Toggle signature help (if signature.enabled = true)
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				keymap = { preset = 'super-tab' },
				appearance = {
				  -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				  -- Adjusts spacing to ensure icons are aligned
				  nerd_font_variant = 'Nerd Font'
				},
				-- (Default) Only show the documentation popup when manually triggered
				completion = { documentation = { auto_show = false } },

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
				  default = { 'lsp', 'path', 'snippets', 'buffer' },
				},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" }
	  },
	  opts_extend = { "sources.default" }
	}

}
]]--
-- Setup lazy.nvim INCLUDING PLUGINS
require("lazy").setup({
	spec = { {import="plugins"}},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install =  {colorscheme =  {"habamax"} },
	-- automatically check for plugin updates
	checker =  {enabled = true} ,
},{})
local builtin = require("telescope.builtin")
vim.keymap.set('n', '<leader>g', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

vim.lsp.enable("jdtls")

require("moonfly")
vim.cmd.colorscheme "moonfly"

