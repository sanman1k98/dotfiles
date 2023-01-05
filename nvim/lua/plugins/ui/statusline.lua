-- TODO create my own components
return {
  lualine = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = {
      options = {
        globalstatus = true,
        component_separators = { left = "|", right = "|"},
        section_separators = { left = "", right = ""},
        disabled_filetypes = { statusline = { "lazy", "alpha"} },
      }
    },
  },
  feline = {
    "feline-nvim/feline.nvim",
    event = "VeryLazy",
    config = function()
      local comps = nil
      if vim.g.colors_name == "catppuccin" then
        comps = require("catppuccin.groups.integrations.feline").get()
      end
      require("feline").setup {
        components = comps
      }
    end,
  },
  mini = {
    "echasnovski/mini.statusline",
    event = "VeryLazy",
    config = function()
      require("mini.statusline").setup{
        -- do not set `laststatus=2`
        set_vim_settings = false,
      }
    end,
  },
}
