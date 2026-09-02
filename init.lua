-- Mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.tabstop = 4      			   --Number of spaces in a tab
vim.opt.shiftwidth = 4   			   --Number of spaces for auto-tab
vim.opt.number = true     		    	 --Display Line Numbers
vim.opt.relativenumber = true 		     --Display relative Line Numbers
vim.opt.filetype = "on" 				 --FileName Hilighting
vim.opt.smartindent = true               --Does Smart Indenting after hitting enter (gg=G to indent whole file)

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

require("lazy").setup({
	spec = { {import="plugins"}},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install =  {colorscheme =  {"habamax"} },
	checker =  {enabled = true} ,
},{})

vim.lsp.enable("jdtls")
vim.lsp.enable("basedpyright")
require("keybinds")



