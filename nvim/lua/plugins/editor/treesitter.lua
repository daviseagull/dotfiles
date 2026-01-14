-- Treesitter: Syntax highlighting and code parsing
-- Configured with parsers for all your languages

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
      -- Your languages
      'typescript',
      'tsx',
      'javascript',
      'python',
      'yaml',
      'json',
      'terraform',
      'hcl',
      'toml',
    },
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      -- If you are experiencing weird indenting issues, add the language to
      -- the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  configs = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
