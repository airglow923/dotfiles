local present, lspconfig = pcall(require, "lspconfig")

if not present then
  vim.notify(debug.getinfo(1, "S").source .. ": Failed to load 'lspconfig'")
  return
end

local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

for _, lsp in ipairs(require("custom.configs.packages").lspconfig) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

--
-- lspconfig.pyright.setup { blabla}
