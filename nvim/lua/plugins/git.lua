local map = require "util.map"

-- which-key group labels
map.set {
  prefix = "<leader>g",
  name = "git",
  d = { name = "diff" },
  h = { name = "hunk" },
}

return {
  -- diffview
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
    },
    keys = map.lazykeys({
      prefix = "<leader>g",
      d = {
        h = {
          desc = "history",
          vim.cmd.DiffviewFileHistory,
        },
        i = {
          desc = "against staged",
          function() vim.cmd.DiffviewOpen "--staged" end,
        },
        c = {
          desc = "against HEAD",
          vim.cmd.DiffviewOpen,
        },
      },
    }),
    opts = {
      enhanced_diff_hl = true,
      show_help_hints = false,
      file_panel = {
        listing_style = "list",
        win_config = {
          width = 30
        },
      },
    },
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = function()
      local gs = require "gitsigns"
      local keymaps = {
        prefix = "<leader>g",
        h = {
          name = "hunk",
          p = {
            desc = "preview inline",
            function() gs.preview_hunk_inline() end,
          },
          s = {
            desc = "stage",
            function() gs.stage_hunk() end,
          },
          u = {
            desc = "undo stage",
            function() gs.undo_stage_hunk() end,
          },
          l = {
            desc = "current buffer",
            function() gs.setloclist() end,
          },
        },
      }
      return {
        base = "HEAD",
        on_attach = function()
          map.set(keymaps)
        end,
      }
    end,
  },

  -- neogit
  {
    "TimUntersberger/neogit",
    cmd = "Neogit",
    config = true,
  },
}
