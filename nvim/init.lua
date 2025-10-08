-- Load core config
require('config.options')
require("config.keymaps")

-- Add plugins
vim.pack.add({
  { src = "https://github.com/loctvl842/monokai-pro.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/folke/trouble.nvim" },
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp" },
  { src = "https://github.com/folke/which-key.nvim" },
})

-- Load plugin configurations
require('plugins.mini')
require('plugins.treesitter')
require('plugins.lspconfig')
require('plugins.fzf')
require('plugins.conform')
require('plugins.trouble')
require('plugins.neo-tree')
require('plugins.luasnip')
require('plugins.blink-cmp')
require('plugins.which-key')
require('plugins.monokai')
require('plugins.lualine')
require('plugins.gitsigns')
