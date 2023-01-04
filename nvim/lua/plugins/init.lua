-- TODO: maybe rename this file to `misc.lua`

return {
  "nvim-lua/plenary.nvim",
  { dir = "~/Projects/luauto.nvim" },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      local g = vim.g
      g.startuptime_sort = 0
      g.startuptime_event_width = 0   -- fit width
    end,
  },
  "echasnovski/mini.nvim",
}
