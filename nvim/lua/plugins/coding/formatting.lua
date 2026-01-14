-- Formatting: Conform.nvim for auto-formatting on save
-- Configured with formatters for all your languages

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable format_on_save for languages without standardized style
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
          async = false, -- Format synchronously to avoid buffer modified state
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- TypeScript/JavaScript (use prettierd with prettier fallback)
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      -- Python (use ruff formatter)
      python = { 'ruff_format' },
      -- YAML
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      -- JSON
      json = { 'prettierd', 'prettier', stop_after_first = true },
      -- Terraform
      terraform = { 'terraform_fmt' },
      tf = { 'terraform_fmt' },
      -- TOML
      toml = { 'taplo' },
      -- Markdown
      markdown = { 'prettierd', 'prettier', stop_after_first = true },
    },
  },
}
