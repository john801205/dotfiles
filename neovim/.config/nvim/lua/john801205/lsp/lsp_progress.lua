---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()

---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
local function lsp_progress_notify(ev)
	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
	if not client or type(value) ~= "table" then
		return
	end
	local p = progress[client.id]

	for i = 1, #p + 1 do
		if i == #p + 1 or p[i].token == ev.data.params.token then
			p[i] = {
				token = ev.data.params.token,
				msg = ("[%3d%%] %s%s"):format(
					value.kind == "end" and 100 or value.percentage or 0,
					value.title or "",
					value.message and (" *%s*"):format(value.message) or ""
				),
				done = value.kind == "end",
			}
			break
		end
	end

	local msg = {} ---@type string[]
	progress[client.id] = vim.tbl_filter(function(v)
		return table.insert(msg, v.msg) or not v.done
	end, p)

	---@type snacks.notifier.Notif.opts
	local opts = {
		id = "lsp_progress_" .. client.id,
		title = client.name,
		history = false,
		timeout = false, -- keep showing the notification until finished
		opts = function(notif)
			if #progress[client.id] == 0 then
				notif.timeout = nil -- reset to use default timeout
				notif.icon = " "
			else
				local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
				notif.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end
		end,
	}
	vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, opts)
end

vim.api.nvim_create_autocmd("LspProgress", {
	group = vim.api.nvim_create_augroup('john801205.lsp.progress_notify', { clear = true }),
	callback = lsp_progress_notify,
})
