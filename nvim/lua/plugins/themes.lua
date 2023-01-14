return {  -- configurations are in the colors directory 
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
