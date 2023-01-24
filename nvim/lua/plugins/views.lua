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

  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 1, -- width of the Zen window
        height = 1, -- height of the Zen window
      },
      options = {
        -- laststatus = 0,
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
        },
        twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        kitty = { enabled = false },
      },
      on_open = function()
        local kitty = require "util.kitty"
        kitty.ctl("set-font-size", { "+4" })
        kitty.ctl("set-spacing", { "padding=60", })
      end,
      on_close = function()
        local kitty = require "util.kitty"
        kitty.ctl("set-font-size", { "0" })
        kitty.ctl("set-spacing", { "padding=default" })
      end,
    },
    keys = map.lazykeys({
      prefix = "<leader>t",
      Z = { function() require("zen-mode").toggle() end, desc = "Zen mode" },
    }),
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
    event = "BufReadPost",
    dependencies = "trouble.nvim",
    config = true,
    -- stylua: ignore
    keys = map.lazykeys({
      prefix = "<leader>x",
      t = { "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      tt = { "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo Trouble" },
      T = { "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
    }),
  },
}
