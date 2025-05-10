local function is_scala_project()
	-- since we are using metals language server, we check if there is any
	-- metals-related files to decide whether this is a scala project
	return vim.fs.root(0, '.metals') ~= nil
end

if is_scala_project() then
	require("metals")
	_G.attach_metals_for_scala_projects()
else
	require("jdtls")
	_G.attch_jdtls_for_java_projects()
end
