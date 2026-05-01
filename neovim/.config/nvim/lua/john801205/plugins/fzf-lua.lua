return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		-- calling `setup` is optional for customization
		local fzf = require("fzf-lua")
		fzf.setup({
			actions = {
				files = {
					true, -- inherit from defaults
					["alt-l"] = fzf.actions.file_sel_to_ll,
				},
			},
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
