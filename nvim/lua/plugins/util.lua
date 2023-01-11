return {
  -- dependency for a lot of plugins
  "nvim-lua/plenary.nvim",

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
  {
    enabled = false,
    "echasnovski/mini.nvim",
  },
}
