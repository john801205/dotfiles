vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
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

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99

vim.opt.splitright = true

vim.opt.winborder = 'rounded'
vim.diagnostic.config({
  virtual_text = true,
})

