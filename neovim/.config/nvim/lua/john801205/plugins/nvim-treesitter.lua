
--- @param args vim.api.keyset.create_autocmd.callback_args
local function start_treesitter(args)
	local filetype = args.match
	local bufno = args.buf
	local lang = vim.treesitter.language.get_lang(filetype)
	if not lang then
		return
	end

	local function start()
		vim.wo.foldmethod = 'expr'
		vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		if lang ~= 'markdown' then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
		vim.treesitter.start(bufno, lang)
	end

	--- @return boolean
	local function check()
		if vim.treesitter.language.add(lang) then
			return true
		end

		return false
	end

	local function install_check_and_start()
		require("nvim-treesitter").install(lang):await(function()
			if check() then
				start()
			end
		end)
	end


	--- @type table<string, nvim-treesitter.ParserInfo>
	local parsers = require('nvim-treesitter.parsers')
	if parsers[lang] == nil then
		return
	elseif check() then
		start()
	else
		install_check_and_start()
	end
end

local function is_UI_available()
	return #vim.api.nvim_list_uis() > 0
end

--- @type string
local augroup_id = 'john801205.nvim-treesitter'

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = function()
		if is_UI_available() then
			require('nvim-treesitter').update()
		else
			require('nvim-treesitter').update():wait()
		end
	end,
	config = function ()
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup(augroup_id, { clear = true }),
			pattern = { '*' },
			callback = start_treesitter,
		})
	end,
	deactivate = function()
		vim.api.nvim_del_augroup_by_name(augroup_id)
	end,
}
