local present, null_ls = pcall(require, "null-ls")

if not present then
  vim.notify(debug.getinfo(1, "S").source .. ": Failed to load 'null-ls'")
  return
end

local b = null_ls.builtins

local sources = {
  b.formatting.black,
  b.formatting.clang_format,
  b.formatting.prettier,
  b.formatting.stylua,
  b.formatting.shfmt,

  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function null_ls_on_attach_nvim_0_8(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format {
          bufnr = bufnr,
          filter = function(client)
            return client.name == "null-ls"
          end,
        }
      end,
    })
  end
end

local function null_ls_on_attach_below_nvim_0_8(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.formatting_sync()
      end,
    })
  end
end

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = vim.fn.has "nvim-0.8" and null_ls_on_attach_nvim_0_8 or null_ls_on_attach_below_nvim_0_8,
}
