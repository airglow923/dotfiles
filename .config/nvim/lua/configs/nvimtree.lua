local opts = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return {
  "nvim-tree/nvim-tree.lua",
  -- installed by nvchad
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = opts,
}
