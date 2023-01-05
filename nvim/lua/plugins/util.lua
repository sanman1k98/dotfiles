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
  "echasnovski/mini.nvim",

  -- popup for keymaps
  {
    "folke/which-key.nvim",
    cmd = "WhichKey",
    config = {
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
      },
      key_labels = {
        ["<leader>"] = "SPACE",
        ["<cr>"] = "RETURN",
        ["<tab>"] = "TAB",
      },
      show_help = false,
      show_keys = true,
    }
  }
}
