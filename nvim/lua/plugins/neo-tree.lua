return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    opts = {
      window = {
        position = "right",
      },
      default_component_configs = {
        git_status = {
          symbols = {
            added = "✚",
            deleted = "✖",
            modified = "",
            renamed = "󰁕",
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
    },
  },
}
