local settings = require "user.settings"

local mode = "light"

local themes = {
  light = "tokyonight-day",
  dark  = "carbonfox",
}

vim.opt.bg = mode
vim.g.colors_name = themes[mode]

require "conf.options"
require "conf.globals"

require("util.lazy").setup("plugins", {
  root = settings.pkg_root,
  defaults = { lazy = true },
  install = {
    colorscheme = { "carbonfox", "habamax" },
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
  },
})

vim.cmd.colorscheme(themes[mode])
