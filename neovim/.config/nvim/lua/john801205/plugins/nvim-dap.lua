return {
	"mfussenegger/nvim-dap",
	version = "*",
	lazy = true,
	config = function()
		-- load the dap configurations
		require("john801205.dap")
	end,
}
