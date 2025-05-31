local jdtls = require("john801205.lsp.nvim-jdtls")
local metals = require("john801205.lsp.nvim-metals")

local function is_scala_project()
	-- since we are using metals language server for scala, we check if there is
	-- any metals-related files to decide whether this is a scala project
	return vim.fs.root(0, '.metals') ~= nil
end

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup('john801205.lsp.java', { clear = true }),
	pattern = { "java" },
	callback = function()
		if is_scala_project() then
			metals.initialize_or_attach()
		else
			jdtls.start_or_attach()
		end
	end,
})
