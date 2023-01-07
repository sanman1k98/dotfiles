local settings = require "user.settings"
local lazypath = settings.pkg_root.."/lazy.nvim"

local function clone()
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end

if not vim.loop.fs_stat(lazypath) then
  clone()
end
vim.opt.runtimepath:prepend(lazypath)

return require("lazy")
