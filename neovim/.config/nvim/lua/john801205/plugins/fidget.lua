local function is_UI_available()
	return #vim.api.nvim_list_uis() > 0
end

return {
	"j-hui/fidget.nvim",
	version = "*",
	opts = {
		notification = {
			override_vim_notify = is_UI_available(),
		},
	},
}
