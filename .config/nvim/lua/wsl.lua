local wsl_clip = "/mnt/c/Windows/System32/clip.exe"

if not vim.fn.has "wsl" or not vim.fn.executable(wsl_clip) then
  return
end

if vim.fn.has "nvim-0.7" then
  vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Copy VIM buffer to Windows' clipboard",
    group = vim.api.nvim_create_augroup("WSLYank", { clear = true }),
    pattern = "*",
    callback = function()
      if vim.v.event.operator == "y" then
        -- works with both vim.fn.getreg(0) and vim.fn.getreg('"')
        vim.fn.system(wsl_clip, vim.fn.getreg(0))
      end
    end,
  })
else
  vim.cmd(string.format(
    [[
    augroup WSLYank
      autocmd!
      autocmd TextYankPost * if v:event.operator ==# "y" |
          \ call system("%s", @0) | endif
    augroup END
  ]],
    wsl_clip
  ))
end
