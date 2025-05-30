--- @type table<string, boolean|nil>
local has_parser_for = {}

--- @param args vim.api.keyset.create_autocmd.callback_args
local function start_treesitter(args)
	local filetype = args.match
	local bufno = args.buf
	local lang = vim.treesitter.language.get_lang(filetype)
	if not lang then
		return
	end

	local function start()
		vim.treesitter.start(bufno, lang)
		vim.wo.foldmethod = 'expr'
		vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end

	--- @return boolean
	local function check()
		if vim.treesitter.language.add(lang) then
			has_parser_for[lang] = true
			return true
		end

		-- Because the parser could exist after installation, we don't update
		-- `has_parser_for` here
		return false
	end

	local function install_check_and_start()
		require("nvim-treesitter").install(lang):await(function()
			if check() then
				start()
			end

			-- Manually update `has_parser_for` since the parser remains
			-- unavailable even after an attempted installation.
			has_parser_for[lang] = false
		end)
	end


	local exists = has_parser_for[lang]
	if exists == false then
	elseif exists == true then
		start()
	elseif check() then
		start()
	else
		install_check_and_start()
	end
end

--- @type string
local augroup_id = 'nvim-treesitter.start'

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function ()
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup(augroup_id, { clear = true }),
			pattern = { '*' },
			callback = start_treesitter,
		})
	end,
	deactivate = function()
		has_parser_for = {}
		vim.api.nvim_del_augroup_by_name(augroup_id)
	end,
}
