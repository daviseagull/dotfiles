vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Disable arrow keys
vim.keymap.set({ "n", "v" }, "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set({ "n", "v" }, "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set({ "n", "v" }, "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set({ "n", "v" }, "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- System clipboard keybinds (explicit access only)
vim.keymap.set({ "n", "v" }, "<leader>sy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>sY", '"+Y', { desc = "Copy line to system clipboard" })

vim.keymap.set("v", "<leader>sx", '"+x', { desc = "Cut to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>sp", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>sP", '"+P', { desc = "Paste from system clipboard before cursor" })

-- Save file
vim.keymap.set({ "n", "i" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")
