local function load_modules(modules)
  for _, module in ipairs(modules) do
    local present, ret = pcall(require, module)

    if not present then
      vim.notify("Failed to load " .. ret)
    end
  end
end

local modules = { "custom.vim_builtins", "custom.lsp" }

load_modules(modules)
