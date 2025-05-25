local detail = false
local function toggle_file_detail_view()
	detail = not detail
	if detail then
		require("oil").set_columns({ "permissions", "size", "mtime", "icon" })
	else
		require("oil").set_columns({ "icon" })
	end
end

return {
	'stevearc/oil.nvim',
	version = "*",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
		},
		keymaps = {
			["gd"] = {
				desc = "Toggle file detail view",
				callback = toggle_file_detail_view,
			},
		},
	},
	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
