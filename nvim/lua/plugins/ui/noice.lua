-- noice.nvim: Enhanced UI for messages, cmdline and popupmenu
-- Provides a modern interface for command line, notifications, and LSP progress

return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  opts = {
    lsp = {
      -- Override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      
      -- Show LSP progress notifications
      progress = {
        enabled = true,
        format = 'lsp_progress',
        format_done = 'lsp_progress_done',
      },
      
      -- Show hover and signature help in a floating window
      hover = {
        enabled = true,
      },
      signature = {
        enabled = true,
      },
    },
    
    -- Presets for easier configuration
    presets = {
      bottom_search = true, -- Use a classic bottom cmdline for search
      command_palette = true, -- Position the cmdline and popupmenu together
      long_message_to_split = true, -- Long messages will be sent to a split
      inc_rename = false, -- Enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- Add a border to hover docs and signature help
    },
    
    -- Command line configuration
    cmdline = {
      enabled = true,
      view = 'cmdline_popup', -- Use popup view for cmdline
      format = {
        cmdline = { icon = '>' },
        search_down = { icon = '/' },
        search_up = { icon = '?' },
        filter = { icon = '$' },
        lua = { icon = '' },
        help = { icon = '?' },
      },
    },
    
    -- Messages configuration
    messages = {
      enabled = true,
      view = 'notify', -- Default view for messages
      view_error = 'notify', -- View for errors
      view_warn = 'notify', -- View for warnings
      view_history = 'messages', -- View for :messages
      view_search = 'virtualtext', -- View for search count messages
    },
    
    -- Popupmenu configuration
    popupmenu = {
      enabled = true,
      backend = 'nui', -- Backend to use: 'nui' or 'cmp'
    },
    
    -- Routes configuration to filter and redirect messages
    routes = {
      {
        filter = {
          event = 'msg_show',
          kind = '',
          find = 'written',
        },
        opts = { skip = true }, -- Skip "written" messages
      },
    },
    
    -- Views configuration
    views = {
      cmdline_popup = {
        position = {
          row = '50%',
          col = '50%',
        },
        size = {
          width = 60,
          height = 'auto',
        },
      },
      popupmenu = {
        relative = 'editor',
        position = {
          row = '60%',
          col = '50%',
        },
        size = {
          width = 60,
          height = 10,
        },
        border = {
          style = 'rounded',
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
        },
      },
    },
  },
}
