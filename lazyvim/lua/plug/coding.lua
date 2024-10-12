local map = require("util.map")

return {
  -- split/join
  {
    "Wansmer/treesj",
    opts = {
      use_default_keymaps = false,
      max_join_length = 150,
    },
    keys = map.lazykeys {
      prefix = "<leader>j",
      label = "split/join",
      { "j", function() require("treesj").toggle() end, desc = "Toggle split" },
    },
  },

  -- annotations generator
  -- {
  --   "danymat/neogen",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = {
  --     input_after_comment = false,
  --   },
  --   keys = {
  --     { "<leader>ng", function() require("neogen").generate() end, desc = "generate annotations" },
  --   }
  -- }
}
