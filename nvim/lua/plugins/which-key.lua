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
