return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		-- File operations
		{
			"<leader><space>",
			"<cmd>FzfLua files<cr>",
			desc = "Find Files (Root Dir)",
		},

		-- Search
		{
			"<leader>/",
			"<cmd>FzfLua lgrep_curbuf<cr>",
			desc = "Grep (current buffer)",
		},
		{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Root Dir)" },
		{ "<leader>sG", "<cmd>FzfLua live_grep cwd=false<cr>", desc = "Grep (cwd)" },
		{ "<leader>sw", "<cmd>FzfLua grep_cword<cr>", desc = "Word (Root Dir)" },
		{ "<leader>sW", "<cmd>FzfLua grep_cword cwd=false<cr>", desc = "Word (cwd)" },
		{
			"<leader>sw",
			"<cmd>FzfLua grep_visual<cr>",
			mode = "v",
			desc = "Selection (Root Dir)",
		},
		{ "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },

		-- Buffers and tabs
		{ "<leader>b", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
		{ "<leader><tab><tab>", "<cmd>FzfLua tabs<cr>", desc = "Tabs" },

		-- Commands and help
		{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
		{ "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
		{ "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },

		-- LSP
		{ "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Goto Symbol" },
		{
			"<leader>sS",
			"<cmd>FzfLua lsp_live_workspace_symbols<cr>",
			desc = "Goto Symbol (Workspace)",
		},

		-- Diagnostics
		{
			"<leader>sd",
			"<cmd>FzfLua diagnostics_document<cr>",
			desc = "Document Diagnostics",
		},
		{
			"<leader>sD",
			"<cmd>FzfLua diagnostics_workspace<cr>",
			desc = "Workspace Diagnostics",
		},
	},
	config = function(_, opts)
		if opts[1] == "default-title" then
			-- Use the same prompt for all pickers for profile `default-title`
			local function fix(t)
				t.prompt = t.prompt ~= nil and " " or nil
				for _, v in pairs(t) do
					if type(v) == "table" then
						fix(v)
					end
				end
				return t
			end
			opts = vim.tbl_deep_extend("force", fix(require("fzf-lua.profiles.default-title")), opts)
			opts[1] = nil
		end
		require("fzf-lua").setup(opts)
	end,
	opts = function(_, opts)
		local config = require("fzf-lua.config")
		local actions = require("fzf-lua.actions")

		-- Quickfix
		config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
		config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
		config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
		config.defaults.keymap.fzf["ctrl-x"] = "jump"
		config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
		config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
		config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
		config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

		-- Toggle root dir / cwd
		config.defaults.actions.files["ctrl-r"] = function(_, ctx)
			local o = vim.deepcopy(ctx.__call_opts)
			o.root = o.root == false
			o.cwd = nil
			o.buf = ctx.__CTX.bufnr
			require("fzf-lua")[ctx.__INFO.cmd](o)
		end
		config.defaults.actions.files["alt-c"] = config.defaults.actions.files["ctrl-r"]
		config.defaults.actions.files["ctrl-alt-r"] = function(_, ctx)
			local o = vim.deepcopy(ctx.__call_opts)
			o.root = o.root == false
			o.cwd = nil
			o.buf = ctx.__CTX.bufnr
			require("fzf-lua")[ctx.__INFO.cmd](o)
		end

		-- Custom LazyVim actions
		local img_previewer ---@type string[]?
		for _, v in ipairs({
			{ cmd = "ueberzug", args = {} },
			{ cmd = "chafa", args = { "{file}", "--format=symbols" } },
			{ cmd = "viu", args = { "-b" } },
		}) do
			if vim.fn.executable(v.cmd) == 1 then
				img_previewer = vim.list_extend({ v.cmd }, v.args)
				break
			end
		end

		return {
			"default-title",
			fzf_colors = true,
			fzf_opts = {
				["--no-scrollbar"] = true,
			},
			defaults = {
				-- LazyVim root detection
				formatter = "path.filename_first",
			},
			previewers = {
				builtin = {
					extensions = {
						["png"] = img_previewer,
						["jpg"] = img_previewer,
						["jpeg"] = img_previewer,
						["gif"] = img_previewer,
						["webp"] = img_previewer,
					},
					ueberzug_scaler = "fit_contain",
				},
			},
			-- Custom window options
			winopts = {
				width = 0.8,
				height = 0.8,
				row = 0.5,
				col = 0.5,
				preview = {
					scrollchars = { "┃", "" },
				},
			},
			files = {
				cwd_prompt = false,
				actions = {
					["alt-i"] = { actions.toggle_ignore },
					["alt-h"] = { actions.toggle_hidden },
				},
			},
			grep = {
				actions = {
					["alt-i"] = { actions.toggle_ignore },
					["alt-h"] = { actions.toggle_hidden },
				},
			},
			lsp = {
				code_actions = {
					previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
				},
			},
		}
	end,
	init = function()
		-- Register UI select
		vim.schedule(function()
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "fzf-lua" } })
				local opts = require("lazy.core.plugin").values("fzf-lua", "opts", false)
				require("fzf-lua").register_ui_select(opts.ui_select or nil)
				return vim.ui.select(...)
			end
		end)
	end,
}
