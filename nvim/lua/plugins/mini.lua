return {
	"nvim-mini/mini.nvim",
	version = false,
	config = function()
		-- Auto-close brackets, quotes, etc.
		require('mini.pairs').setup()
		
		-- Add/change/delete surrounding characters (quotes, brackets, etc.)
		require('mini.surround').setup()
		
		-- Enhanced text objects (better a/i text objects)
		require('mini.ai').setup()
	end,
}
