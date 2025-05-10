local M = {
	"scalameta/nvim-metals",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	ft = { "scala", "sbt"},
}

function M.opts()
	local opts = require("metals").bare_config()
	opts = vim.tbl_deep_extend('force', opts, {
		init_options = {
			statusBarProvider = "off",
		},
		settings = {
			metals = {
				useGlobalExecutable = true,
				defaultBspToBuildTool = true,
			},
		},
		find_root_dir_max_project_nesting = 2,
	})
	return opts
end

function M.config(self, opts)
	local function attach()
		require("metals").initialize_or_attach(opts)
	end

	local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = self.ft,
		callback = attach,
		group = nvim_metals_group,
	})

	_G.attach_metals_for_scala_projects = attach
end

return M
