require('config.options')
require("config.keymaps")

vim.pack.add({
  { src = "https://github.com/loctvl842/monokai-pro.nvim"},
  { src = "https://github.com/nvim-lualine/lualine.nvim"},
  { src = "https://github.com/lewis6991/gitsigns.nvim"},
  { src = "https://github.com/nvim-lua/plenary.nvim"},
  { src = "https://github.com/MunifTanjim/nui.nvim"},
  { src = "https://github.com/nvim-mini/mini.nvim"},
  { src = "https://github.com/nvim-treesitter/nvim-treesitter"},
  { src = "https://github.com/neovim/nvim-lspconfig"},
  { src = "https://github.com/ibhagwan/fzf-lua"},
  { src = "https://github.com/kdheepak/lazygit.nvim"},
  { src = "https://github.com/stevearc/conform.nvim"},
  { src = "https://github.com/folke/trouble.nvim"},
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim"},
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp", version = "1.*"},
  { src = "https://github.com/folke/which-key.nvim" },
})

require('mini.icons').mock_nvim_web_devicons()
require('mini.ai').setup({})
require('mini.surround').setup({})

require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
}

require("fzf-lua").setup({})

require("conform").setup({
  formatters = {
    eslint_d = { command = "eslint_d", args = { "--fix-to-stdout", "-" }, stdin = true },
    stylua = { command = "stylua", args = { "-" }, stdin = true },
  },
  format_on_save = true,
})

require("trouble").setup({
  icons = true,
  use_diagnostic_signs = true,
    modes = {
        lsp = {
        win = { position = "right" },
        },
    },
})

require("neo-tree").setup({
  sources = { "filesystem", "document_symbols" },
  open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
  filesystem = {
    hijack_netrw_behavior = "open_current",
    bind_to_cwd = false,
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,
    group_empty_dirs = true,
  },
  window = {
    position = "right",
    mappings = {
      ["<space>"] = "none",
      ["l"] = "open",
      ["h"] = "close_node",
      ["Y"] = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.fn.setreg("+", path, "c")
      end,
      ["O"] = function(state)
        require("lazy.util").open(state.tree:get_node().path, { system = true })
      end,
      ["P"] = { "toggle_preview", config = { use_float = false } },
    },
  },
  default_component_configs = {
    indent = {
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    git_status = {
      symbols = {
        added = "✚",
        deleted = "✖",
        modified = "",
        renamed = "󰁕",
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
  },
})

require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
    fuzzy = {
		implementation = "lua"  -- or "prefer_rust"
	},
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
})

require("which-key").setup({
    preset = "helix",
      delay = 200,
      icons = {
        mappings = true,
        breadcrumb = "»",
        separator = "➜",
        group = "",
      },
})
require('which-key').add({
    { "<leader>b", group = "Buffers", },
    { "<leader><tab>", group = "Tabs", },
    { "<leader>s", group = "System"},
    { "<leader>t", group = "Trouble",  },
    { "<leader>f", group = "Search", },
})

require("monokai-pro").setup({
  transparent_background = false,
  terminal_colors = true,
  devicons = true, -- highlight devicons
  styles = {
    comment = { italic = true },
    keyword = { italic = true },       -- any other keyword
    type = { italic = true },          -- (preferred) int, long, char, etc
    storageclass = { italic = true },  -- static, register, volatile, etc
    structure = { italic = true },     -- struct, union, enum, etc
    parameter = { italic = true },     -- parameter pass in function
    annotation = { italic = true },
    tag_attribute = { italic = true }, -- attribute of tag in reactjs
  },
  filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
  -- Enable this will disable filter option
  day_night = {
    enable = false,            -- turn off by default
    day_filter = "pro",        -- classic | octagon | pro | machine | ristretto | spectrum
    night_filter = "spectrum", -- classic | octagon | pro | machine | ristretto | spectrum
  },
  inc_search = "background", -- underline | background
  background_clear = {
    -- "float_win",
    "toggleterm",
    "telescope",
    -- "which-key",
    "renamer",
    "notify",
    -- "nvim-tree",
    -- "neo-tree",
    -- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
  },-- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
  plugins = {
    bufferline = {
      underline_selected = false,
      underline_visible = false,
    },
    indent_blankline = {
      context_highlight = "default", -- default | pro
      context_start_underline = false,
    },
  },
})
vim.cmd([[colorscheme monokai-pro]])

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'monokai-pro',  -- matches your colorscheme
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})

require('gitsigns').setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },
  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },
})
