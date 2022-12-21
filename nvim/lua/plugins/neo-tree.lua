local neotree = {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "NeoTree"
}

neotree.config = function()
  require("neo-tree").setup {
    -- :h neotree
  }
end

return neotree
