return {
	{
		"neovim/nvim-lspconfig",
		config = function()

		end
	},
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "Y",
					package_pending = "...",
					package_uninstalled = "X"
				}
			}
		}
	},
	{
		'williamboman/mason-lspconfig.nvim',
		opts = {
			automatic_enable = {
				exclude = {
					'jdtls'
				}
			}
		},
	},
	{ "mfussenegger/nvim-jdtls" }
}
