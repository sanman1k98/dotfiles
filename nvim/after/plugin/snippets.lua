
local setup = function()
  local packadd = vim.cmd.packadd

  packadd "LuaSnip"
  packadd "friendly-snippets"

  local loaded, luasnip = pcall(require, "luasnip")
  if not loaded then
    vim.notify("LuaSnip plugin not found", vim.log.levels.ERROR)
    return
  end

  luasnip.config.set_config {
    updateevents = "TextChanged,TextChangedI",
  }

  require("luasnip.loaders.from_vscode").lazy_load()
end

