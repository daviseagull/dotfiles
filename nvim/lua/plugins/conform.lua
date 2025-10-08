require("conform").setup({
  formatters = {
    eslint_d = { command = "eslint_d", args = { "--fix-to-stdout", "-" }, stdin = true },
    stylua = { command = "stylua", args = { "-" }, stdin = true },
  },
  format_on_save = true,
})
