vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.diagnostic.config({ virtual_text = true })

local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Completion
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 10
