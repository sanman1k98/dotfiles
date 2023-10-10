return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- disable formatting on save
      autoformat = false,
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
}
