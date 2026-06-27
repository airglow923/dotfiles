local packages = require("configs.packages").mason

local opts = {
  ensure_installed = vim.tbl_extend("force", packages.lsp, packages.dap, packages.linter, packages.formatter),
}

return {
  "williamboman/mason.nvim",
  opts = opts,
}
