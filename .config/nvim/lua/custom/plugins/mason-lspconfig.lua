local present, mason_lspconfig = pcall(require, "mason-lspconfig")

if not present then
  vim.notify(debug.getinfo(1, "S").source .. ": Failed to load 'mason-lspconfig'")
  return
end

local chad_lspconfig = require "plugins.configs.lspconfig"

mason_lspconfig.setup {
  ensure_installed = require("custom.plugins.lsp").lspconfig,
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      on_attach = chad_lspconfig.on_attach,
      capabilities = chad_lspconfig.capabilities,
    }
  end,
}
