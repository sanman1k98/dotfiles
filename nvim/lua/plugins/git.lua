local gitsigns = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre"
}

gitsigns.config = function()
  local gs = require "gitsigns"
  gs.setup {
    -- TODO: configuration and keymaps
  }
end

local diffview = {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewTogleFiles",
    "DiffviewFocusFiles",
  },
  config = function()
    require("diffview").setup()
  end,
}

local neogit = {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  config = function()
    local ng = require "neogit"
    ng.setup {
      -- TODO
    }
  end,
}

return {
  gitsigns,
  diffview,
  neogit,
}
