return {
	"ibhagwan/fzf-lua",
	version = "*",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		local fzf = require("fzf-lua")
		fzf.setup({
			files = {
				follow = true, -- follow symlinks
			},
			grep = {
				follow = true, -- follow symlinks
			}
		})
		fzf.register_ui_select()
	end,
}
