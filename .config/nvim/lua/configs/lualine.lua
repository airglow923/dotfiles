local options = {
  icons_enabled = true,
  theme = "auto",
  component_separators = { left = " ", right = " " },
  section_separators = { left = "", right = "" },
  disabled_filetypes = {
    statusline = {},
    winbar = {},
  },
  ignore_focus = {},
  always_divide_middle = true,
  always_show_tabline = true,
  globalstatus = false,
  refresh = {
    statusline = 100,
    tabline = 100,
    winbar = 100,
  },
  disabled_winbar_filetypes = {
    statusline = { "NvimTree_1", "lazy", "help" },
    winbar = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename", "filesize" },
    lualine_x = { "encoding", require("codex").status() },
    lualine_y = { "progress" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

require("lualine").setup(options)
