local plugin = {
  "feline-nvim/feline.nvim",
  requires = {
    "kyazdani42/nvim-web-devicons",
  },
  opt = false,
  -- disabled = true,
}

plugin.config = function()
  local comps = nil
  local cat = package.loaded.catppuccin or pcall(require, "catppuccin")
  if cat then
    comps = require("catppuccin.groups.integrations.feline").get()
  end
  local feline = require "feline"
  feline.setup({
    components = comps,
  })
  feline.winbar.setup()
end

return plugin
