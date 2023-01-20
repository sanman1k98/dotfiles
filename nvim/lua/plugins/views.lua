local map = require "util.map"

return {
  -- file tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    keys = require("util.map").lazykeys {
      ["<leader>te"] = { "<cmd>Neotree toggle filesystem<cr>", "file explorer" },
    },
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
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = map.lazykeys({
      prefix = "<leader>x",
      name = "diagnostics/quickfix",
      x = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Document Diagnostics (Trouble)" },
      X = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
    }),
  },

  -- todo comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    -- event = "BufReadPost",
    config = true,
    -- stylua: ignore
    keys = {
      prefix = "<leader>x",
      t = { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      tt = { "<leader>xtt", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo Trouble" },
      T = { "<leader>xT", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
    },
  },
}
