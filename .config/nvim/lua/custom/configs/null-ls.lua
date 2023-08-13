local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  b.formatting.black,
  b.formatting.clang_format,
  b.formatting.deno_fmt,
  b.formatting.gofumpt,
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } },
  b.formatting.stylua,
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function below_nvim_0_8(client, bufnr)
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

local function nvim_0_8_and_above(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { bufnr = bufnr }
      end,
    })
  end
end

null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = (vim.fn.has "nvim-0.8") and nvim_0_8_and_above or below_nvim_0_8,
}
