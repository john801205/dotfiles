return {
	"olimorris/codecompanion.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	opts = {
		strategies = {
			chat = {
				adapter = "ollama",
			},
			inline = {
				adapter = "ollama",
			},
			cmd = {
				adapter = "ollama",
			}
		},
		display = {
			chat = {
				auto_scroll = false
			},
		},
	},
	lazy = true,
}
