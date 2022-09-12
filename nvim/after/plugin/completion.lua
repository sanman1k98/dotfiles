
local setup = function()
  local packadd = vim.cmd.packadd

  packadd "nvim-cmp"
  packadd "cmp-nvim-lsp"
  packadd "cmp-spell"
  packadd "cmp-buffer"
  packadd "cmp-path"
  packadd "cmp-cmdline"

  packadd "LuaSnip"
  packadd "friendly-snippets"
  packadd "cmp_luasnip"

  local loaded_cmp, cmp = pcall(require, "cmp")
  if not loaded_cmp then
    vim.notify("Autocompletion plugins not found", vim.log.levels.ERROR)
    return
  end

  local loaded_luasnip, luasnip = pcall(require, "luasnip")
  if not loaded_luasnip then
    vim.notify("LuaSnip plugins not found", vim.log.levels.ERROR)
    return
  end


end


vim.api.nvim_create_autocmd("InsertEnter", {
  callback = setup, 
  once = true,
})
