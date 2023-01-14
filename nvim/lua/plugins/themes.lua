-- TODO: there is a better way to do this...

local themes = {  -- configurations are in the colors directory 
  {
    "catppuccin/nvim", name = "catppuccin",
    lazy = not vim.startswith(vim.g.colors_name, "catppuccin"),
  },
  {
    "rose-pine/neovim", name = "rose-pine",
    lazy = vim.g.colors_name ~= "rose-pine",
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = not vim.startswith(vim.g.colors_name, "github"),
  },
  {
    "folke/tokyonight.nvim",
    lazy = not vim.startswith(vim.g.colors_name, "tokyonight"),
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = vim.g.colors_name ~= "kanagawa",
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = not vim.endswith(vim.g.colors_name, "fox"),
  },
}

local set_theme = function()
  vim.cmd.colorscheme(vim.g.colors_name)
end

for _, t in ipairs(themes) do
  t.config = not t.lazy and set_theme or nil
end

return themes
