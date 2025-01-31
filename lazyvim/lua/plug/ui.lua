return {
  -- neo-tree customizations
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      add_blank_line_at_top = true,
      hide_root_node = true,
      retain_hidden_root_indent = true,
      window = { width = 30 },
      default_component_configs = {
        indent = {
          with_markers = false,
          with_expanders = false,
        },
      },
    },
  },

  -- TODO comments customizations
  {
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        multiline = false,
      },
    },
  },

  -- lualine customizations
  {
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
  },

  -- eye-candy keys screencaster
  {
    "nvchad/showkeys",
    cmd = "ShowkeysToggle",
    opts = {
      timeout = 1,
      maxkeys = 5,
    },
  },

  {
    'folke/snacks.nvim',
    opts = {
      indent = { enabled = false },
      scroll = { enabled = false },
    },
  },
}
