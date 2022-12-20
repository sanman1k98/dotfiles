local plugin = {
  "lewis6991/gitsigns.nvim",
}

plugin.config = function()
  local gitsigns = require "gitsigns"
  gitsigns.setup {
    -- :h gitsigns
  }
end

return plugin
