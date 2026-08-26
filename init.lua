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
vim.keymap.set('n', '<C-s>', ':wa<enter>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>saq', ':wa<enter>:q<enter>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>c', ':noh<enter>', {noremap = true, silent = true} )
vim.keymap.set('n', '<C-i>', vim.lsp.buf.hover, {noremap = true , silent = true})

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
vim.lsp.enable("basedpyrite")

require("vscode").setup({
	color_overrides = {
		vscBack = '#060606',
		vscTabCurrent = '#060606',
		vscTabOutSide = '#060606',
		vscTabOther = '#060606',
		vscPopupBack = '#161616'

	}
});
vim.cmd.colorscheme "vscode"

