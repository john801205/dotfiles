require("john801205.lsp.lsp_progress")

require("john801205.lsp.java")
require("john801205.lsp.lua_ls")

vim.lsp.enable('gopls')

vim.lsp.enable('rust_analyzer')

vim.lsp.config('clangd', {
	init_options = {
		fallbackFlags = { '-std=c++20', '-Wall', '-Wextra', '-Wpedantic' },
	},
})
vim.lsp.enable('clangd')

vim.lsp.enable('pyright')

vim.lsp.enable('marksman')

vim.lsp.enable('bashls')
