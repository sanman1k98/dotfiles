return {
  -- lualine customizations
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = { left = "│", right = "│" },
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_y = {
        {
          function()
            local line = vim.fn.line('.')
            local col = vim.fn.virtcol('.')
            return string.format('%03d:%03d', line, col)
          end,
        },
      },
      lualine_z = {
        { "progress", fmt = string.upper },
      },
    },
  },
}
