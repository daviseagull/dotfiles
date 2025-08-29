return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"lua_ls", -- Lua
				"jdtls", -- Java
				"ts_ls", -- TypeScript/JavaScript
				"sqlls", -- SQL
				"html", -- HTML
				"cssls", -- CSS
				"dockerls", -- Dockerfile
				"docker_compose_language_service", -- Docker Compose
				"terraformls", -- Terraform
				"yamlls", -- YAML (for GitHub Actions)
			},
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Set up diagnostic keymaps (available globally)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })

			-- LSP attach keymaps (only available when LSP is attached to buffer)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Navigation
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = ev.buf, desc = "Go to declaration" })
					vim.keymap.set(
						"n",
						"gi",
						vim.lsp.buf.implementation,
						{ buffer = ev.buf, desc = "Go to implementation" }
					)
					vim.keymap.set(
						"n",
						"gt",
						vim.lsp.buf.type_definition,
						{ buffer = ev.buf, desc = "Go to type definition" }
					)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Show references" })

					-- Information
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Show hover information" })
					vim.keymap.set(
						"n",
						"<C-k>",
						vim.lsp.buf.signature_help,
						{ buffer = ev.buf, desc = "Show signature help" }
					)

					-- Code actions
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						{ buffer = ev.buf, desc = "Code action" }
					)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename symbol" })

					-- Formatting
					vim.keymap.set("n", "<leader>f", function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = ev.buf, desc = "Format code" })

					-- Workspace management
					vim.keymap.set(
						"n",
						"<leader>wa",
						vim.lsp.buf.add_workspace_folder,
						{ buffer = ev.buf, desc = "Add workspace folder" }
					)
					vim.keymap.set(
						"n",
						"<leader>wr",
						vim.lsp.buf.remove_workspace_folder,
						{ buffer = ev.buf, desc = "Remove workspace folder" }
					)
					vim.keymap.set("n", "<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, { buffer = ev.buf, desc = "List workspace folders" })
				end,
			})

			-- Configure each LSP server
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				jdtls = {},
				ts_ls = {},
				sqlls = {},
				html = {},
				cssls = {},
				dockerls = {},
				docker_compose_language_service = {},
				yamlls = {
					settings = {
						yaml = {
							schemas = {
								["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
							},
						},
					},
				},
			}

			-- Setup each server
			for server, config in pairs(servers) do
				lspconfig[server].setup(config)
			end

			-- Custom OpenTofu Language Server setup
			-- This creates a custom LSP configuration for tofu-ls
			local configs = require("lspconfig.configs")

			if not configs.tofuls then
				configs.tofuls = {
					default_config = {
						cmd = { "tofu-ls", "serve" },
						filetypes = { "hcl", "terraform", "tofu", "tf" },
						root_dir = lspconfig.util.root_pattern(".terraform", ".git", "main.tf", ".tofu"),
						settings = {},
					},
				}
			end

			-- Only setup if tofu-ls is executable
			if vim.fn.executable("tofu-ls") == 1 then
				lspconfig.tofuls.setup({})
			else
				vim.notify(
					"tofu-ls not found. Please install from https://github.com/opentofu/tofu-ls",
					vim.log.levels.WARN
				)
			end
		end,
	},
}
