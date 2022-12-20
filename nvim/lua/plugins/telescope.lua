local plugin = {
  "nvim-telescope/telescope.nvim",
  requires = "nvim-lua/plenary.nvim",
}

plugin.config = function()
  local telescope = require "telescope"
  telescope.setup {
    -- :h telescope
  }
end

return plugin
