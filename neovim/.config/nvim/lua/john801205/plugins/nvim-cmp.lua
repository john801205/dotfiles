return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"neovim/nvim-lspconfig",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		-- "hrsh7th/cmp-path",
		-- "hrsh7th/cmp-cmdline",
	},
	config = function()
		local cmp = require("cmp")

		vim.keymap.set('i', '<C-x><C-o>', function()
			cmp.complete()
		end, { noremap = true, silent = true })

		cmp.setup({
			completion = {
				autocomplete = false,
				completeopt = "menu,menuone,noselect",
			},
			snippet = {
				expand = function(args)
					vim.snippet.expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({ border = 'rounded' }),
				documentation = cmp.config.window.bordered({ border = 'rounded' }),
			},
			mapping = cmp.mapping.preset.insert({
				-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				['<CR>'] = cmp.mapping.confirm({ select = true }),
				['<Esc>'] = cmp.mapping.abort(),
			}),
			sources = cmp.config.sources({ { name = 'nvim_lsp' } }, { { name = 'buffer' } }),
		})

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline({ '/', '?' }, {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = { { name = 'buffer' } },
		-- })

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		-- cmp.setup.cmdline(':', {
		-- 	mapping = cmp.mapping.preset.cmdline(),
		-- 	sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } }),
		-- 	matching = {
		-- 		disallow_fullfuzzy_matching = false,
		-- 		disallow_fuzzy_matching = false,
		-- 		disallow_partial_fuzzy_matching = false,
		-- 		disallow_partial_matching = false,
		-- 		disallow_prefix_unmatching = false,
		-- 		disallow_symbol_nonprefix_matching = false,
		-- 	},
		-- })
	end,
}
