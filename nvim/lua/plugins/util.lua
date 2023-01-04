return {
  -- dependency for a lot of plugins
  "nvim-lua/plenary.nvim",

  -- me
  {
    dir = "~/Projects/luauto.nvim",
    lazy = false,
    init = function()
      local auto = require "luauto"
      _G.vim.autocmd = auto.cmd
      _G.vim.augroup = auto.group
    end,
  },

  -- profiling
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      local g = vim.g
      g.startuptime_sort = 0
      g.startuptime_event_width = 0   -- dynamic
    end,
  },

  -- lotta useful Lua modules
  "echasnovski/mini.nvim",
}
