require("neo-tree").setup({
  hide_root_node = true,
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
