local util   = require "util"
local colors = require "util.colors"

colors.setup({
  dark = "carbonfox",
  light = "dawnfox",
})

util.setup()
require "conf.globals"
require "conf.options"

require("lazy").setup("plugins", {
  root = vim.fn.stdpath("data").."/lazy",
  defaults = { lazy = true },
  install = {
    colorscheme = { colors.get(), "habamax" },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "zipPlugin",
        "tutor",
        "tohtml",
      }
    }
  },
})
