vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- FZF
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<CR>', { desc = "Files" })
vim.keymap.set('n', '<leader>fd', '<cmd>FzfLua live_grep<CR>', { desc = "Grep" })
vim.keymap.set('n', '<leader>fb', '<cmd>FzfLua blines<CR>', { desc = "Grep Buffer" })
vim.keymap.set('n', "<leader>b", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
vim.keymap.set('n', "<leader><tab><tab>", "<cmd>FzfLua tabs<cr>", { desc = "Tabs" })

-- WINDOW MOVEMENT
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- CLIPBOARD
vim.keymap.set({ "n", "v" }, "<leader>sy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>sY", '"+Y', { desc = "Copy line to system clipboard" })
vim.keymap.set("v", "<leader>sx", '"+x', { desc = "Cut to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>sp", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>sP", '"+P', { desc = "Paste from system clipboard before cursor" })

-- ACTIONS
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- NEO_TREE
vim.keymap.set('n', '<leader>e', "<cmd>Neotree toggle<cr>", { desc = "Files" })

-- LAZY_GIT
vim.keymap.set('n', '<leader>g', "<cmd>LazyGit<cr>", { desc = "Git" })

-- TROUBLE
vim.keymap.set('n', '<leader>tx', "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set('n', '<leader>tX', "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Buffer Diagnostics (Trouble)" })
vim.keymap.set('n', '<leader>ts', "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set('n', '<leader>tS', "<cmd>Trouble lsp toggle<cr>", { desc = "LSP references/definitions/... (Trouble)" })
vim.keymap.set('n', '<leader>tL', "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set('n', '<leader>tQ', "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
