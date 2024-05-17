return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
      },
    },
  },

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

  {
    -- TODO: fix highlighting before the comment keyword
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        multiline = false,
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    cond = false,
  },
}
