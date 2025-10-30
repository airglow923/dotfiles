local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- local lspconfig = require "lspconfig"
local servers = require("configs.packages").lspconfig

local on_attach_wo_format = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  on_attach(client, bufnr)
end

for _, server in ipairs(servers) do
  vim.lsp.config(server, {
    on_attach = server == "sqls" and on_attach_wo_format or on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })

  vim.lsp.enable(server)
end
