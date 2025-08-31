-- Usage:
--
-- ### Debugging a script file
-- ```sh
-- uv run debugpy --listen 5678 --wait-for-client ${program} ${arguments}
-- ```
--
-- ### Debugging a module
-- ```sh
-- uv run debugpy --listen 5678 --wait-for-client -m ${module} ${arguments}
-- ```
--
-- [Reference](https://github.com/microsoft/debugpy/wiki/Command-Line-Reference)
--
local dap = require('dap')

dap.adapters.python = function(cb, config)
	local adapter = {
		type = 'server',
		port = config.connect.port,
		host = config.connect.host,
	}

	cb(adapter)
end

dap.configurations.python = {
	{
		type = 'python',
		request = 'attach',
		name = 'attach',
		connect = function()
			local host = vim.fn.input('Host [127.0.0.1]: ')
			host = host ~= '' and host or '127.0.0.1'
			local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
			return { host = host, port = port }
		end,
		justMyCode = false,
	},
}
