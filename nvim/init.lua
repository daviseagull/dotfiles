vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set({ "n", "v" }, "<leader>sy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>sY", '"+Y', { desc = "Copy line to system clipboard" })
vim.keymap.set("v", "<leader>sx", '"+x', { desc = "Cut to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>sp", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>sP", '"+P', { desc = "Paste from system clipboard before cursor" })

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with plugins
require("lazy").setup({
  -- Add your plugins here
  {
    'nvim-mini/mini.nvim',
    version = false,
    config = function()
      require('mini.surround').setup()
      require('mini.comment').setup()
      require('mini.pairs').setup()
      require('mini.ai').setup()
      require('mini.statusline').setup()
    end,
  },

  -- Add more plugins as needed
}, {
  -- Optional lazy.nvim config options
  checker = { enabled = true },
  install = { colorscheme = { "habamax" } },
})

-- General Neovim settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
