local M = {}

M.treesitter = {
  ensure_installed = require("configs.packages").treesitter,
  indent = {
    enable = true,
  },
}

return M
