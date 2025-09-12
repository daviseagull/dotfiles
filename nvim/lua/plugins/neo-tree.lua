return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = false, -- neo-tree will lazily load itself
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer NeoTree (Root Dir)" },
			{ "<leader>E", "<cmd>Neotree toggle dir=vim.uv.cwd()<cr>", desc = "Explorer NeoTree (cwd)" },
		},
		opts = {
			sources = { "filesystem", "document_symbols" },
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			filesystem = {
				hijack_netrw_behavior = "open_current",
				bind_to_cwd = false,
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
			window = {
				position = "right",
				mappings = {
					["<space>"] = "none",
					["l"] = "open",
					["h"] = "close_node",
					["Y"] = {
						function(state)
							local node = state.tree:get_node()
							local path = node:get_id()
							vim.fn.setreg("+", path, "c")
						end,
						desc = "Copy Path to Clipboard",
					},
					["O"] = {
						function(state)
							require("lazy.util").open(state.tree:get_node().path, { system = true })
						end,
						desc = "Open with System Application",
					},
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
		},
	},
}
