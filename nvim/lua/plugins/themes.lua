local plugins = {
  -- configurations are in the colors directory 
  {
    "catppuccin/nvim",
    name = "catppuccin",
    pattern = "^catppuccin",
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    pattern = "^rose",
  },
  {
    "projekt0n/github-nvim-theme",
    pattern = "^github",
  },
  {
    "folke/tokyonight.nvim",
    pattern = "^tokyonight",
  },
  {
    "rebelot/kanagawa.nvim",
    pattern = "kanagawa",
  },
  {
    "EdenEast/nightfox.nvim",
    pattern = "fox$",
  },
}

for _, p in ipairs(plugins) do
  p = type(p) == "string" and { p } or p
  p.init = require("util.colors").plugin_init
end

return plugins
