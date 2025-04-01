return {
	"neovim/nvim-lspconfig",
	dependencies = { "j-hui/fidget.nvim" },
	version = "*",
	config = function()
		require("lspconfig").gopls.setup({})
		require("lspconfig").rust_analyzer.setup({})
		require("lspconfig").clangd.setup({
			init_options = {
				fallbackFlags = { '-std=c++20', '-Wall', '-Wextra', '-Wpedantic' },
			},
		})
		require("lspconfig").pyright.setup({})
		require("lspconfig").metals.setup({
			filetypes = { 'scala', 'java' },
			init_options = {
				statusBarProvider = "off",
			},
			settings = {
				metals = {
					defaultBspToBuildTool = true,
				},
			},
		})
		-- require('lspconfig').jdtls.setup({})
	end,
}
