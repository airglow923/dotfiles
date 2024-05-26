vim.api.nvim_create_user_command("ReloadConfig", function()
  for name, _ in pairs(package.loaded) do
    if name:match "^user" then
      package.loaded[name] = nil
      require(name)
    end
  end

  -- dofile(vim.env.MYVIMRC)
end, {})
