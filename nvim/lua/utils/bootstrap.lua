local M = {}

local paq_path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
local paq_exists = not vim.fn.empty(vim.fn.glob(paq_path)) > 0

M.add_paq = function()
  if paq_exists then
    vim.notify("The Paq install directory is not empty: " .. paq_path, vim.log.levels.ERROR)
    return
  end
  vim.fn.system {
    "git",
    "clone",
    "--depth=1",
    "https://github.com/savq/paq-nvim.git",
    paq_path
  }
  vim.cmd.packadd "paq-nvim"
end

M.install_plugins = function()
  M.add_paq()
  vim.api.nvim_create_autocmd("User", {
    pattern = "PaqDoneInstall",
    command = "quit"
  })
  local plugins = require "plugins"
  require("paq")(plugins):install()
end

return M
