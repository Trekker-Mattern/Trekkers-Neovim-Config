local builtin = require("telescope.builtin")
local harpoon = require("harpoon")


-- VSCode Swap
	vim.keymap.set('n', '<A-k>', ':m .+1<CR>==zv', {noremap = true, silent = true})
	vim.keymap.set('n', '<A-j>', ':m .-2<CR>==zv', {noremap = true, silent = true})


-- Diagnostics
	vim.keymap.set('n', '<leader>h', ':lua vim.diagnostic.open_float()<enter>' ,{noremap = true, silent = true})
	vim.keymap.set('n', '<C-i>', vim.lsp.buf.hover, {noremap = true , silent = true})

-- Saving
	vim.keymap.set('n', '<C-s>', ':wa<enter>', {noremap = true, silent = true})
	vim.keymap.set('n', '<leader>saq', ':wa<enter>:q<enter>', {noremap = true, silent = true})

-- Telescope
	vim.keymap.set('n', '<leader>g', builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

-- Harpoon
		vim.keymap.set("n", "<leader>a", function() 
			harpoon:list():add()
			vim.notify("Added file to Harpoon")
		end)
		vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() vim.notify("File Removed from Harpoon") end)
		vim.keymap.set("n", "<C-j>", function() harpoon:list():select(1) end)
		vim.keymap.set("n", "<C-k>", function() harpoon:list():select(2) end)
		vim.keymap.set("n", "<C-l>", function() harpoon:list():select(3) end)
		vim.keymap.set("n", "<C-;>", function() harpoon:list():select(4) end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
		vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)



	vim.keymap.set('n', '<leader>n', '<Cmd>Neotree toggle<CR>')

-- Misc
	vim.keymap.set('n', '<leader>c', ':noh<enter>', {noremap = true, silent = true} ) -- Clears /find buffer




