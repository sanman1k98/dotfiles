local util = require "util"

util.setup()
require "conf.globals"
require "conf.options"

vim.g.colors_name = "tokyonight"

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
