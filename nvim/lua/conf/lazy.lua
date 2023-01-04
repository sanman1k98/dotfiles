local M = {}

local package_root = vim.fn.stdpath("data").."/lazy"
local install_path = package_root.."/lazy.nvim"

function M.clone()
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    install_path,
  }
end

function M.init()
  if not vim.loop.fs_stat(install_path) then
    M.clone()
  end
  vim.opt.runtimepath:prepend(install_path)
end

M.config = {
  root = package_root,
  defaults = { lazy = true },
  install = {
    colorscheme = { "catppuccin", "habamax" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "zipPlugin",
        "tutor",
        "tohtml",
      }
    }
  }
}

function M.setup(spec)
  M.init()
  require("lazy").setup(spec, M.config)
end

M.setup "plugins"

return M
