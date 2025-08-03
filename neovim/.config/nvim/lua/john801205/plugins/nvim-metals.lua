return {
	"scalameta/nvim-metals",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
	},
	lazy = true,
	config = function()
		require("metals").setup_dap()
	end,
}
