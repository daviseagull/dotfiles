return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			-- Web Development
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			less = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "yamlfmt" },
			markdown = { "prettier" },
			["markdown.mdx"] = { "prettier" },
			graphql = { "prettier" },

			-- Systems Programming
			go = { "gofmt" },
			rust = { "rustfmt" },
			c = { "clang_format" },
			cpp = { "clang_format" },

			-- Scripting
			python = { "black" },
			lua = { "stylua" },
			sh = { "shfmt" },
			bash = { "shfmt" },

			-- Other
			toml = { "taplo" },
			xml = { "xmlformat" },
		},
		formatters = {
			yamlfmt = {
				command = "yamlfmt",
				args = { "-formatter", "basic", "-indentless_arrays=true" },
			},
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = true,
		},
	},
}
