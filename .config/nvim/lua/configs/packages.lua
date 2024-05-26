-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md

return {
  mason = {
    lsp = {
      "clangd", -- clangd
      "cmake-language-server", -- cmake
      "css-lsp", -- cssls
      "deno", -- denols
      "gopls", -- gopls
      "html-lsp", -- html
      "kotlin-language-server", -- kotlin_language_server
      "lua-language-server", -- lua_ls
      "pyright", -- pyright
      "rust-analyzer", -- rust_analyzer
      "typescript-language-server", -- tsserver
    },
    dap = {},
    linter = {
      "shellcheck",
    },
    formatter = {
      "black",
      "clang-format",
      "cmakelang",
      -- "gofumpt",
      "ktlint",
      "prettier",
      "shfmt",
      "stylua",
    },
  },
  lspconfig = {
    "clangd", -- clangd
    "cmake", -- cmake-language-server
    "cssls", -- css-lsp
    "denols", -- deno
    "gopls", -- gopls
    "html", -- html-lsp
    "kotlin_language_server", -- kotlin-language-server
    "lua_ls", -- lua-language-server
    "pyright", -- pyright
    "rust_analyzer", -- rust-analyzer
    "tsserver", -- tsserver
  },
  treesitter = {
    "bash",
    "c",
    "cpp",
    "css",
    "go",
    "html",
    "javascript",
    "kotlin",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "tsx",
    "typescript",
    "vim",
  },
}
