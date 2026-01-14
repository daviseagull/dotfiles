-- nvim-notify: Better notification manager
-- Provides a nicer UI for Neovim notifications

return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require('notify')
    
    notify.setup({
      -- Animation style
      stages = 'fade_in_slide_out',
      
      -- Default timeout for notifications
      timeout = 3000,
      
      -- Background color
      background_colour = '#000000',
      
      -- Icons for different log levels
      icons = {
        ERROR = '',
        WARN = '',
        INFO = '',
        DEBUG = '',
        TRACE = '',
      },
      
      -- Max width of notification window
      max_width = 50,
      
      -- Minimum level to show
      level = 'info',
      
      -- Position of notifications
      top_down = true,
    })
    
    -- Set as default notification handler
    vim.notify = notify
  end,
}
