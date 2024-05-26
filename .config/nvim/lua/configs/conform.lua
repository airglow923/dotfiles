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

    kotlin = { "ktlint" },
    sh = { "shfmt" },
    lua = { "stylua" },
  },
  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

require("conform").setup(options)
