local plugin = {
  "nvim-telescope/telescope.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  cmd = "Telescope",
}

plugin.config = function()
  local telescope = require "telescope"
  telescope.setup {
    -- :h telescope
  }
  telescope.load_extension "notify"
  telescope.load_extension "noice"
end

return plugin
