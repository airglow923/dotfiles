local opts = {
  treesitter = {
    ensure_installed = require("configs.packages").treesitter,
    indent = {
      enable = true,
    },
  },
}

return {
  "nvim-treesitter/nvim-treesitter",
  opts = opts,
}
