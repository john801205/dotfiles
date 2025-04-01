return {
	"neovim/nvim-lspconfig",
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
			settings = {
				metals = {
					defaultBspToBuildTool = true,
				},
			},
		})
		-- require('lspconfig').jdtls.setup({})
	end,
}
