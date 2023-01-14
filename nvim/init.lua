local mode = "dark"
local themes = {
  light = "tokyonight-day",
  dark  = "tokyonight-night",
}

-- used to determine whether a colorscheme plugin should be lazy loaded or not
vim.g.colors_name = themes[mode]
vim.opt.bg = mode

require "conf.options"
require "conf.globals"

require("util.lazy").setup("plugins", {
  root = vim.fn.stdpath("data").."/lazy",
  defaults = { lazy = true },
  install = {
    colorscheme = { themes[mode], "habamax" },
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
