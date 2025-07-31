return {
  "akinsho/bufferline.nvim",
  enabled = false,
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    { "<leader>bd", "<Cmd>BufferLinePickClose<CR>", desc = "Pick buffer to close" },
    { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin buffer" },
    { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
    { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
    { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
    { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
    { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
    { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
    { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
    { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
    { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
    { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
    { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
    { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
    { "<leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>", desc = "Go to last buffer" },
  },
  opts = {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      style_preset = "default", -- or "minimal"
      themable = true,
      numbers = "none", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      close_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "icon", -- | 'underline' | 'none',
      },
      buffer_close_icon = "󰅖",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      --- name_formatter can be used to change the buffer's label in the bufferline.
      --- Please note some names can/will break the
      --- bufferline so use this at your discretion knowing that it has
      --- some limitations that will *NOT* be fixed.
      max_name_length = 30,
      max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
      truncate_names = true, -- whether or not tab names should be truncated
      tab_size = 21,
      diagnostics = "nvim_lsp",
      diagnostics_update_in_insert = false,
      -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      custom_filter = function(buf_number)
        -- filter out filetypes you don't want to see
        if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
          return true
        end
        -- filter out by buffer name
        if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
          return true
        end
        -- filter out based on arbitrary rules
        -- e.g. filter out vim help files
        if vim.fn.bufname(buf_number):match("%.md") then
          return true
        end
      end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "",
          text_align = "right",
          separator = false,
        },
      },
      color_icons = true, -- whether or not to add the filetype icon highlights
      show_buffer_icons = true, -- disable filetype icons for buffers
      show_buffer_close_icons = true,
      show_close_icon = true,
      show_tab_indicators = true,
      show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "padded_slant", -- | "slope" | "thick" | "thin" | { 'any', 'any' },
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      sort_by = "insert_after_current", -- |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    },
    highlights = {
      fill = {
        bg = "none", -- Make background transparent to blend with Rose Pine
      },
      background = {
        bg = "none",
      },
      tab = {
        bg = "none",
      },
      tab_selected = {
        bg = "none",
      },
      tab_separator = {
        bg = "none",
      },
      tab_separator_selected = {
        bg = "none",
      },
      tab_close = {
        bg = "none",
      },
      close_button = {
        bg = "none",
      },
      close_button_visible = {
        bg = "none",
      },
      close_button_selected = {
        bg = "none",
      },
      buffer_visible = {
        bg = "none",
      },
      buffer_selected = {
        bold = true,
        italic = false,
        bg = "none",
      },
      numbers = {
        bg = "none",
      },
      numbers_visible = {
        bg = "none",
      },
      numbers_selected = {
        bg = "none",
        bold = true,
      },
      diagnostic = {
        bg = "none",
      },
      diagnostic_visible = {
        bg = "none",
      },
      diagnostic_selected = {
        bold = true,
        italic = false,
        bg = "none",
      },
      hint = {
        bg = "none",
      },
      hint_visible = {
        bg = "none",
      },
      hint_selected = {
        bold = true,
        italic = false,
        bg = "none",
      },
      hint_diagnostic = {
        bg = "none",
      },
      hint_diagnostic_visible = {
        bg = "none",
      },
      hint_diagnostic_selected = {
        bg = "none",
        bold = true,
      },
      info = {
        bg = "none",
      },
      info_visible = {
        bg = "none",
      },
      info_selected = {
        bg = "none",
        bold = true,
      },
      info_diagnostic = {
        bg = "none",
      },
      info_diagnostic_visible = {
        bg = "none",
      },
      info_diagnostic_selected = {
        bg = "none",
        bold = true,
      },
      warning = {
        bg = "none",
      },
      warning_visible = {
        bg = "none",
      },
      warning_selected = {
        bg = "none",
        bold = true,
      },
      warning_diagnostic = {
        bg = "none",
      },
      warning_diagnostic_visible = {
        bg = "none",
      },
      warning_diagnostic_selected = {
        bg = "none",
        bold = true,
      },
      error = {
        bg = "none",
      },
      error_visible = {
        bg = "none",
      },
      error_selected = {
        bg = "none",
        bold = true,
      },
      error_diagnostic = {
        bg = "none",
      },
      error_diagnostic_visible = {
        bg = "none",
      },
      error_diagnostic_selected = {
        bg = "none",
        bold = true,
      },
      modified = {
        bg = "none",
      },
      modified_visible = {
        bg = "none",
      },
      modified_selected = {
        bg = "none",
      },
      duplicate_selected = {
        bg = "none",
        bold = true,
      },
      duplicate_visible = {
        bg = "none",
      },
      duplicate = {
        bg = "none",
      },
      separator_selected = {
        bg = "none",
      },
      separator_visible = {
        bg = "none",
      },
      separator = {
        bg = "none",
      },
      indicator_visible = {
        bg = "none",
      },
      indicator_selected = {
        bg = "none",
      },
      pick_selected = {
        bold = true,
        italic = false,
        bg = "none",
      },
      pick_visible = {
        bold = true,
        italic = false,
        bg = "none",
      },
      pick = {
        bold = true,
        italic = false,
        bg = "none",
      },
      offset_separator = {
        bg = "none",
      },
      trunc_marker = {
        bg = "none",
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd("BufAdd", {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
