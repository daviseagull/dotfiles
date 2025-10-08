vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.diagnostic.config({ virtual_text = true })

vim.opt.number = true
vim.opt.relativenumber = true

-- UI
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true

-- Editing
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.pumheight = 10
