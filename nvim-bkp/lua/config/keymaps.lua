-- Disable arrow keys
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- System clipboard keybinds (explicit access only)
vim.keymap.set({ "n", "v" }, "<leader>sy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>sY", '"+Y', { desc = "Copy line to system clipboard" })

vim.keymap.set("v", "<leader>sx", '"+x', { desc = "Cut to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>sp", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>sP", '"+P', { desc = "Paste from system clipboard before cursor" })
