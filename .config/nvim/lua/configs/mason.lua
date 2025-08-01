local M = {}

local packages = require("configs.packages").mason

M.ensure_installed = vim.tbl_extend("force", packages.lsp, packages.dap, packages.linter, packages.formatter)

return M
