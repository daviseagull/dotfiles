-- trouble.nvim: Pretty diagnostics, references, quickfix and location list
-- Better UI for viewing and navigating diagnostics and other lists

return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = 'Trouble',
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>xs',
      '<cmd>Trouble symbols toggle<cr>',
      desc = 'Symbols (Trouble)',
    },
    {
      '<leader>xl',
      '<cmd>Trouble lsp toggle<cr>',
      desc = 'LSP Definitions / References / ... (Trouble)',
    },
    {
      '<leader>xL',
      '<cmd>Trouble loclist toggle<cr>',
      desc = 'Location List (Trouble)',
    },
    {
      '<leader>xQ',
      '<cmd>Trouble qflist toggle<cr>',
      desc = 'Quickfix List (Trouble)',
    },
  },
  opts = {
    -- Focus the trouble window when opened
    focus = true,
    
    -- Follow the item under the cursor
    follow = true,
    
    -- Auto close when there are no items
    auto_close = false,
    
    -- Auto open when there are items
    auto_open = false,
    
    -- Auto preview the item under the cursor
    auto_preview = true,
    
    -- Auto refresh items
    auto_refresh = true,
    
    -- Indent guides
    indent_guides = true,
    
    -- Mode-specific configurations
    modes = {
      -- Symbols mode configuration (outline)
      symbols = {
        win = {
          position = 'bottom',
          size = {
            height = 10,
          },
        },
      },
      -- LSP mode configuration
      lsp = {
        win = {
          position = 'right',
          size = {
            width = 50,
          },
        },
      },
    },
    
    -- Default window options (for diagnostics, qflist, loclist)
    win = {
      position = 'bottom',
      size = {
        height = 10,
      },
    },
  },
}
