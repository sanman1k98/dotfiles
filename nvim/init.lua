local util = require "util"

local themes = {
  light = "tokyonight-day",
  dark  = "tokyonight-night",
}

util.init()
require "conf.globals"
require "conf.options"

vim.g.colors_name = themes[vim.o.bg]

require("lazy").setup("plugins", {
  root = vim.fn.stdpath("data").."/lazy",
  defaults = { lazy = true },
  install = {
    colorscheme = { vim.g.colors_name, "habamax" },
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
