local detail = false
local function toggle_file_detail_view()
	detail = not detail
	if detail then
		require("oil").set_columns({ "permissions", "size", "mtime", "icon" })
	else
		require("oil").set_columns({ "icon" })
	end
end

local function fzf_dirs()
	local dir = require("oil").get_current_dir()

	local opts = {}
	opts.prompt = "Directories > "
	opts.actions = require("fzf-lua.defaults").defaults.actions.files

	require('fzf-lua').fzf_exec("fd --type d --hidden --follow . " .. dir, opts)
end

local function fzf_files()
	local dir = require("oil").get_current_dir()
	require('fzf-lua').files({cwd=dir})
end

local function fzf_live_grep()
	local dir = require("oil").get_current_dir()
	require('fzf-lua').live_grep({cwd=dir})
end

return {
	'stevearc/oil.nvim',
	version = "*",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		win_options = {
			colorcolumn = "",
		},
		view_options = {
			-- Show files and directories that start with "."
			show_hidden = true,
		},
		keymaps = {
			["<leader>d"] = {desc = "Directories", callback = fzf_dirs, mode = "n"},
			["<leader>f"] = {desc = "Files", callback = fzf_files, mode = "n"},
			["<leader>l"] = {desc = "Live grep", callback = fzf_live_grep, mode = "n"},
			["gd"] = {
				desc = "Toggle file detail view",
				callback = toggle_file_detail_view,
				mode = "n",
			},
		},
		confirmation = {
			border = "rounded",
		},
		progress = {
			border = "rounded",
		},
	},
	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
