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
