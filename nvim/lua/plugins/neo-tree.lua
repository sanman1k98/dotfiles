return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
  end,
  config = {
    add_blank_line_at_top = true,
    hide_root_node = true,
    retain_hidden_root_indent = true,
    window = { width = 30 },
    default_component_configs = {
      indent = {
        with_markers = false,
      }
    },
  },
}
