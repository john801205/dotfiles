
local config_cache = nil
local function configuration()
	if config_cache == nil then
		config_cache = require("metals").bare_config()
		config_cache = vim.tbl_deep_extend('force', config_cache, {
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
	end

	return config_cache
end

local M = {
}

function M.initialize_or_attach()
	require("metals").initialize_or_attach(configuration())
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "scala", "sbt" },
	callback = M.initialize_or_attach,
})

return M
