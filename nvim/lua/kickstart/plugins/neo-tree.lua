-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>e', ':Neotree toggle<CR>', desc = 'Toggle NeoTree', silent = true },
    { '<leader>E', ':Neotree reveal<CR>', desc = 'Reveal file in NeoTree', silent = true },
  },
  opts = {
    hide_root_node = true,
    retain_hidden_root_indent = false,
    window = {
      position = 'right',
    },
    default_component_configs = {
      indent = {
        indent_size = 1,
        padding = 1,
        with_markers = false,
      },
      git_status = {
        symbols = {
          -- Change these to empty strings to hide the icons
          added = '',
          modified = '',
          deleted = '',
          renamed = '',
          untracked = '',
          ignored = '',
          unstaged = '',
          staged = '',
          conflict = '',
        },
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['h'] = 'close_node',
          ['l'] = 'open',
        },
      },
    },
    event_handlers = {
      {
        event = 'neo_tree_buffer_enter',
        handler = function()
          vim.opt_local.statusline = ' '
        end,
      },
    },
  },
}
