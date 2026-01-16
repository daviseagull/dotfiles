-- Core Neovim options and settings
-- This file contains all vim.opt and vim.g configurations

-- Set leader keys before any plugins load
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd Font availability
vim.g.have_nerd_font = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode (useful for resizing splits)
vim.o.mouse = 'a'

-- Don't show the mode (already in statusline)
vim.o.showmode = false

-- Don't sync clipboard between OS and Neovim by default
-- Use <leader>y to explicitly copy to system clipboard
-- vim.schedule(function()
--   vim.o.clipboard = 'unnamedplus'
-- end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor
--  See `:help 'list'` and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Keep cursor centered vertically in the screen
vim.o.scrolloff = 999

-- Remove ~ from empty lines in gutter
vim.o.fillchars = 'eob: '

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
