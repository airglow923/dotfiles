return {
  "lukas-reineke/indent-blankline.nvim",
  -- required for scope
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("ibl").setup()
  end,
}
