local options = {
  formatters_by_ft = {
    python = { "black" },

    c = { "clang-format" },
    cpp = { "clang-format" },
    cmake = { "cmake_format" },

    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    yaml = { "prettier" },

    kotlin = { "ktlint" },
    lua = { "stylua" },
    sh = { "shfmt" },
    sql = { "sql_formatter" },
  },
  format_on_save = {
    -- default value was 500, but ktlint behaves way too slow
    timeout_ms = 3000,
    lsp_fallback = true,
  },
  formatters = {
    sql_formatter = {
      prepend_args = { "-l", "postgresql" },
    },
  },
}

require("conform").setup(options)
