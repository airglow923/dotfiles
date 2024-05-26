-- Retrieved from $VIMRUNTIME/lua/vim/lsp/handlers.lua
local function location_handler(_, result, ctx, config)
  if result == nil or vim.tbl_isempty(result) then
    local _ = vim.log.info() and vim.log.info(ctx.method, "No location found")
    return nil
  end
  local client = vim.lsp.get_client_by_id(ctx.client_id)

  config = config or {}

  local width = vim.fn.winwidth(0)
  local height = vim.fn.winheight(0) * 2

  if height < width then
    vim.cmd "vsplit"
  else
    vim.cmd "split"
  end

  -- textDocument/definition can return Location or Location[]
  -- https://microsoft.github.io/language-server-protocol/specifications/specification-current/#textDocument_definition

  if vim.tbl_islist(result) then
    local title = "LSP locations"
    local items = vim.lsp.util.locations_to_items(result, client.offset_encoding)

    if config.on_list then
      assert(type(config.on_list) == "function", "on_list is not a function")
      config.on_list { title = title, items = items }
    else
      if #result == 1 then
        vim.lsp.util.jump_to_location(result[1], client.offset_encoding, config.reuse_win)
        return
      end
      vim.fn.setqflist({}, " ", { title = title, items = items })
      vim.api.nvim_command "botright copen"
    end
  else
    vim.lsp.util.jump_to_location(result, client.offset_encoding, config.reuse_win)
  end

  return location_handler
end

vim.lsp.handlers["textDocument/definition"] = location_handler
