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
        transparency = true, -- Enable transparent background
      },
    }

    -- Load the colorscheme
    vim.cmd.colorscheme 'rose-pine-moon'
    
    -- Ensure background is fully transparent to inherit terminal opacity
    vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
    vim.cmd('highlight NormalNC guibg=NONE ctermbg=NONE')
    vim.cmd('highlight SignColumn guibg=NONE ctermbg=NONE')
    vim.cmd('highlight LineNr guibg=NONE ctermbg=NONE')
    vim.cmd('highlight CursorLineNr guibg=NONE ctermbg=NONE')
  end,
}
