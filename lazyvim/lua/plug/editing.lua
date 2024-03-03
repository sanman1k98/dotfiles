return {
  -- split/join
  {
    "Wansmer/treesj",
    opts = {
      use_default_keymaps = false,
    },
    keys = {
      { "<leader>jj", function() require("treesj").toggle() end, desc = "toggle" },
      { "<leader>js", function() require("treesj").split() end, desc = "split" },
    },
  },

  -- annotations generator
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = {
      input_after_comment = false,
    },
    keys = {
      { "<leader>ng", function() require("neogen").generate() end, desc = "generate annotations" },
    }
  }
}
