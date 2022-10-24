local present, lspconfig = pcall(require, "lspconfig")

if not present then
  vim.notify(debug.getinfo(1, "S").source .. ": Failed to load 'lspconfig'")
  return
end

local chad_lspconfig = require "plugins.configs.lspconfig"

for _, lsp in ipairs(require("custom.plugins.lsp").lspconfig) do
  lspconfig[lsp].setup {
    on_attach = chad_lspconfig.on_attach,
    capabilities = chad_lspconfig.capabilities,
  }
end
