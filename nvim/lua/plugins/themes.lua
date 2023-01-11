return {  -- configurations are in the colors directory 
  {
    "catppuccin/nvim", name = "catppuccin",
    lazy = not vim.g.colors_name:match("^catppuccin"),
  },
  {
    "rose-pine/neovim", name = "rose-pine",
    lazy = vim.g.colors_name ~= "rose-pine",
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = not vim.g.colors_name:match("^github"),
  },
  {
    "folke/tokyonight.nvim",
    lazy = not vim.g.colors_name:match("^tokyonight"),
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = vim.g.colors_name ~= "kanagawa",
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = not vim.g.colors_name:match("fox$"),
  },
}
