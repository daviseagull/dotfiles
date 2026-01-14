-- Linting: nvim-lint for additional code quality checks
-- Provides linting beyond what LSP offers (ESLint for TS/JS, Ruff for Python)

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'

    -- Configure linters by filetype
    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      python = { 'ruff' },
    }

    -- Create autocommand to run linters
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only run the linter in buffers that you can modify
        if vim.bo.modifiable then
          lint.try_lint()
        end
      end,
    })
  end,
}
