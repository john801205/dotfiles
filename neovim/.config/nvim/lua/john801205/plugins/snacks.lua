local function is_UI_available()
	return #vim.api.nvim_list_uis() > 0
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		input = {
			enabled = is_UI_available(),
		},
		notifier = {
			enabled = is_UI_available(),
		},
	},
}
