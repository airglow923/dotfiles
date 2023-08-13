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
      "gofumpt",
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
    "lua_ls", -- lua-language-server
    "pyright", -- pyright
    "rust_analyzer", -- rust-analyzer
    "tsserver", -- tsserver
  },
}
