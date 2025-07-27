return {
  {
    "f-person/auto-dark-mode.nvim",
    config = function()
      require("auto-dark-mode").setup({
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          vim.cmd("colorscheme tokyonight")
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          vim.cmd("colorscheme tokyonight-day")
        end,
      })
      require("auto-dark-mode").init()
    end,
  },
}
