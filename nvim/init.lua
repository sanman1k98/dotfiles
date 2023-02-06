local util   = require "util"
local colors = require "util.colors"

colors.setup({
  light = true,
  themes = {
    dark = "carbonfox",
    light = "dawnfox",
  }
})

util.setup()
require "conf.globals"    -- TODO: rename to `user.globals`
require "conf.options"    -- TODO: rename to `user.options`

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
