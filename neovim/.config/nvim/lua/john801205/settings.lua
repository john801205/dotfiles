vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.list = true
vim.opt.listchars = {
  tab = ">-",
  trail = "·"
}
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.undofile = true
vim.opt.scrolloff = 5

vim.opt.textwidth = 80
vim.opt.colorcolumn = "+1"

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.diagnostic.config({
  virtual_text = true,
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
