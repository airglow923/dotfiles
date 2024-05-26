-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "chadracula",
  theme_toggle = { "chadracula", "one_light" },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    CursorLine = {
      bg = "one_bg",
    },
  },

  hl_add = {
    NvimTreeOpenedFolderName = {
      fg = "green",
      bold = true,
    },
  },
}

return M
