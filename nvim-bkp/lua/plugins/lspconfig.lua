-- Get capabilities from blink.cmp
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- LSP keymaps and configuration on attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    -- Navigation
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
      vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition,
      vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))

    -- Documentation
    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

    -- Code actions
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, { desc = "Code action" }))
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))

    -- Format via conform
    vim.keymap.set("n", "<leader>cf", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, vim.tbl_extend("force", opts, { desc = "Format" }))

    -- Workspace
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder,
      vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
      vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))
  end,
})

-- Lua
vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git" },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- TypeScript/JavaScript
vim.lsp.config.ts_ls = {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
  capabilities = capabilities,
}

-- Java
vim.lsp.config.jdtls = {
  cmd = { "jdtls" },
  filetypes = { "java" },
  root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
  capabilities = capabilities,
}

-- OpenTofu/Terraform
vim.lsp.config.tofuls = {
  cmd = { "tofu-ls", "serve" },
  filetypes = { "terraform", "terraform-vars" },
  root_markers = { ".terraform", ".git" },
  capabilities = capabilities,
}

-- Enable LSP servers
vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("jdtls")
vim.lsp.enable("tofuls")
