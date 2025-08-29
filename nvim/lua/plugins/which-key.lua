return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 200,
			expand = 1,
			notify = false,
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader><tab>", group = "Tabs" },
					{ "<leader>b", group = "Buffers" },
					{ "<leader>c", group = "Code" },
					{ "<leader>f", group = "Files" },
					{ "<leader>g", group = "Git", mode = { "n", "v" } },
					{ "<leader>q", group = "Quit/Session" },
					{ "<leader>r", group = "Rename" },
					{ "<leader>s", group = "Search" },
					{ "<leader>u", group = "UI/Toggle" },
					{ "<leader>w", group = "Workspace" },
					{ "<leader>x", group = "Diagnostics" },
					{ "g", group = "Goto" },
					{ "z", group = "Fold" },
					{ "]", group = "Next" },
					{ "[", group = "Prev" },
					{ "<leader><space>", hidden = true },
				},
			},
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
}
