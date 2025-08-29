return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"catppuccin/nvim", -- Ensure catppuccin loads first
	},
	event = "VeryLazy",
	opts = function()
		return {
			options = {
				theme = "catppuccin",
				globalstatus = true,
				disabled_filetypes = { statusline = { "dashboard", "alpha" } },
				component_separators = { left = "│", right = "│" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = {
					{
						"mode",
					},
				},
				lualine_b = {
					"branch",
					{
						"diff",
						symbols = {
							added = " ",
							modified = " ",
							removed = " ",
						},
						diff_color = {
							added = { fg = "#a6e3a1" }, -- Catppuccin green
							modified = { fg = "#f9e2af" }, -- Catppuccin yellow
							removed = { fg = "#f38ba8" }, -- Catppuccin red
						},
					},
				},
				lualine_c = {
					{
						"diagnostics",
						sources = { "nvim_diagnostic" },
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
						},
						diagnostics_color = {
							error = { fg = "#f38ba8" }, -- Catppuccin red
							warn = { fg = "#fab387" }, -- Catppuccin peach
							info = { fg = "#89b4fa" }, -- Catppuccin blue
							hint = { fg = "#94e2d5" }, -- Catppuccin teal
						},
					},
				},
				lualine_x = {
					"encoding",
					"filetype",
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "neo-tree", "lazy", "fzf" },
		}
	end,
}
