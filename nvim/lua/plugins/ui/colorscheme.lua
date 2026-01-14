-- Colorscheme configuration
-- Rose Pine theme with moon variant and custom settings

return {
  'rose-pine/neovim',
  name = 'rose-pine',
  priority = 1000, -- Load before all other start plugins
  config = function()
    require('rose-pine').setup {
      variant = 'moon', -- auto, main, moon, or dawn
      styles = {
        italic = false,
      },
    }

    -- Load the colorscheme
    vim.cmd.colorscheme 'rose-pine-moon'
  end,
}
