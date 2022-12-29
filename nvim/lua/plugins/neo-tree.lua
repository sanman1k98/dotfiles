local neotree = {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree"
}

neotree.config = function()
  vim.g.neo_tree_remove_legacy_commands = 1
  require("neo-tree").setup {
    default_component_configs = {
      indent = {
        with_markers = false,
      }
    },
  }
end

return neotree
