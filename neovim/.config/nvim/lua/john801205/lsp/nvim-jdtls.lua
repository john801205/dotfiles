
-- adapted from https://github.com/sykesm/dotfiles/blob/426b6e2660b8286b6969b4a84e0981817d730174/.config/nvim/lua/sykesm/plugins/nvim-jdtls.lua
local function java_home_macos(version)
	local java_home = '/usr/libexec/java_home'
	if not vim.fn.has('mac') then
		return nil
	end
	if not vim.fn.executable(java_home) then
		return nil
	end

	local command = { java_home, '-F' , '-v', version }
	local res = vim.system(command, { text = true }):wait()
	if res.code ~= 0 then
		return nil
	end

	return string.gsub(res.stdout, '[\r\n]+$', '')
end

local function java_runtimes()
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- And search for `interface RuntimeOption`
	-- The `name` is NOT arbitrary, but must match one of the elements from
	-- `enum ExecutionEnvironment` in the link above
	local jdks = {
		{ name = 'JavaSE-21', version = 21 },
		{ name = 'JavaSE-24', version = 24 },
	}

	local runtimes = {}
	for _, jdk in ipairs(jdks) do
		local home = java_home_macos(jdk.version)
		if home ~= nil then
			table.insert(runtimes, { name = jdk.name, path = home })
		end
	end
	return runtimes
end

local function jdtls_cmd(root_dir)
	local cmd = {
		'jdtls',
	}

	local project_name = root_dir and vim.fs.basename(root_dir)
	if project_name then
		vim.list_extend(cmd, {
			'-data',
			vim.fn.stdpath('cache') .. '/jdtls/' .. project_name .. '/workspace',
		})
	end

	return cmd
end

local global_opts_cache = nil
local function global_opts()
	if global_opts_cache == nil then
		global_opts_cache = {
			settings = {
				java = {
					configuration = {
						runtimes = java_runtimes(),
					}
				}
			}
		}
	end

	return global_opts_cache
end

local M = {}

function M.start_or_attach()
	local root_dir = vim.fs.root(0, {".git", "mvnw", "gradlew"})
	local opts = vim.tbl_deep_extend('force', global_opts(), {
		root_dir = root_dir,
		cmd = jdtls_cmd(root_dir),
	})
	require('jdtls').start_or_attach(opts)
end

return M
