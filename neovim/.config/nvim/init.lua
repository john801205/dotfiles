local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

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
vim.opt.scrolloff = 10

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevelstart = 99

require("lazy").setup({
  spec = {
    -- the colorscheme should be available when starting Neovim
    {
      "folke/tokyonight.nvim",
      version = "*",
      lazy = false, -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        -- load the colorscheme here
        vim.cmd([[colorscheme tokyonight-night]])
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function ()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
          ensure_installed = {},
          auto_install = true,
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end
    },
    {
      "neovim/nvim-lspconfig",
      version = "*",
      config = function()
        require("lspconfig").gopls.setup({})
        require("lspconfig").rust_analyzer.setup({})
        require("lspconfig").clangd.setup({
          cmd = {'clangd', '--background-index', '--clang-tidy'},
          init_options = {
            fallbackFlags = { '-std=c++20', '-Wall', '-Wextra', '-Wpedantic' },
          },
        })
      end,
    },
    {
      "folke/which-key.nvim",
      version = "*",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      event = "VeryLazy",
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
    {
      "ibhagwan/fzf-lua",
      version = "*",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
      end
    },
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {}
      end,
    },
  },
  checker = {
    enabled = true,
    frequency = 86400,
  },
})
