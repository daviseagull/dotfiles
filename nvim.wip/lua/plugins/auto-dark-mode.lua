return {
  {
    "f-person/auto-dark-mode.nvim",
    config = function()
      require("auto-dark-mode").setup({
        update_interval = 1000,
        set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          vim.cmd("colorscheme rose-pine-moon")
        end,
        set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          vim.cmd("colorscheme rose-pine-dawn")
        end,
      })
      require("auto-dark-mode").init()
    end,
  },
}
