local settings = require "user.settings"

require "conf.options"
require "conf.globals"

require("util.lazy").setup("plugins", {
  root = settings.pkg_root,
  defaults = { lazy = true },
  install = {
    colorscheme = { "tokyonight", "habamax" },
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

vim.cmd.colorscheme "tokyonight"
