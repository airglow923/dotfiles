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

local get_python_path = function()
  -- pyenv
  local pyenv_path = vim.fn.system("pyenv which python"):gsub("\n", "")
  if vim.fn.filereadable(pyenv_path) == 1 then
    return pyenv_path
  end

  -- virtualenv
  if vim.env.VIRTUAL_ENV then
    return vim.env.VIRTUAL_ENV .. "/bin/python"
  end

  -- system
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

for _, server in ipairs(servers) do
  local settings = {}

  if server == "pyright" then
    settings.python = { pythonPath = get_python_path() }
    vim.print(get_python_path())
  end

  vim.lsp.config(server, {
    on_attach = server == "sqls" and on_attach_wo_format or on_attach,
    on_init = on_init,
    capabilities = capabilities,
    settings = settings,
  })

  vim.lsp.enable(server)
end
