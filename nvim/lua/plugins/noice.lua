return {
	{
		"rcarriga/nvim-notify",
		opts = {
			top_down = false,
		},
	},

	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = function(_, opts)
			opts.presets = {
				command_palette = {
					views = {
						cmdline_popup = {
							position = {
								row = "25%",
								col = "50%",
							},
							size = {
								min_width = 60,
								width = "auto",
								height = "auto",
							},
						},
						cmdline_popupmenu = {
							position = {
								row = "67%",
								col = "50%",
							},
						},
					},
				},
			}
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},
}
