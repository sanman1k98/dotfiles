local map = require("util.map")
local wezterm = require("util.wezterm")

map.set {
  {
    mode = "i",
    { "kj", "<esc>", desc = "ESC" },
    { "<c-f>", "<right>", desc = "->" },
    { "<c-b>", "<left>", desc = "<-" },
  },
  {
    mode = { "i", "x", "n", "s" },
    { "<c-s>", false },
    { "<d-s>", "<cmd>w<cr><esc>", desc = "Write file" },
  },
}

if wezterm.is_wezterm then
  -- Environment variables "CONFIG_COLORS*" are defined in wezterm's config.
  local dark = vim.env.CONFIG_COLORS_DARK
  local light = vim.env.CONFIG_COLORS_LIGHT
  map.set {
    {
      desc = "Toggle colorscheme",
      "<leader>ut",
      function()
        local colors = vim.g.colors_name == dark and light or dark
        wezterm.set_user_var("CONFIG_COLORS", colors)
        vim.env.CONFIG_COLORS = colors
        vim.cmd.colorscheme(colors)
      end,
    }
  }
end
