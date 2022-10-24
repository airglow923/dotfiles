-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md

return {
  mason = {
    "clangd", -- clangd
    "cmake-language-server", -- cmake
    "html-lsp", -- html
    "pyright", -- pyright
    "rust-analyzer", -- rust_analyzer
    "lua-language-server", -- sumneko_lua
    "typescript-language-server", -- tsserver
  },
  lspconfig = {
    "clangd", -- clangd
    "cmake", -- cmake-language-server
    "html", -- html-lsp
    "pyright", -- pyright
    "rust_analyzer", -- rust-analyzer
    "sumneko_lua", -- lua-language-server
    "tsserver", -- tsserver
  },
}
