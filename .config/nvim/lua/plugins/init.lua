return {
  -- greeter
  require "configs.alpha_nvim",

  -- file management
  require "configs.nvimtree",
  require "configs.treesitter",
  require "configs.nvim_surround",
  require "configs.indent_blankline",

  -- lsp, linter, formatters
  require "configs.mason",
  require "configs.conform",
  require "configs.lspconfig",

  -- utilities
  require "configs.suda",
  require "configs.codex",
}
