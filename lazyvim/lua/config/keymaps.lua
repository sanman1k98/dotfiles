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
  local colors_dark, colors_light = vim.env.CONFIG_COLORS_DARK, vim.env.CONFIG_COLORS_LIGHT
  map.set {
    {
      desc = "Toggle colorscheme",
      "<leader>ut",
      function()
        local new_colors = vim.g.colors_name == colors_dark and colors_light or colors_dark
        wezterm.set_user_var("CONFIG_COLORS", new_colors)
        vim.cmd.colorscheme(new_colors)
      end,
    }
  }
end
