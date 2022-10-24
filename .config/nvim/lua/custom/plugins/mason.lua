M = {}

M.override_options = {
  ensure_installed = {
    -- formatter
    "black",
    "clang-format",
    "prettier",
    "shfmt",

    -- linter
    "shellcheck",
  },
}

-- lsp
for _, lsp in ipairs(require("custom.plugins.lsp").mason) do
  table.insert(M.override_options.ensure_installed, lsp)
end

return M
