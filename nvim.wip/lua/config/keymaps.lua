local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local function arrow_key_warning()
	vim.notify("Use hjkl, not arrow keys!", vim.log.levels.WARN)
end

-- Disable arrow keys in normal, insert, and visual mode with warning
for _, mode in ipairs({ "n", "i", "v" }) do
	keymap(mode, "<Up>", arrow_key_warning, opts)
	keymap(mode, "<Down>", arrow_key_warning, opts)
	keymap(mode, "<Left>", arrow_key_warning, opts)
	keymap(mode, "<Right>", arrow_key_warning, opts)
end
