local noice = {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  event = "VimEnter",
}

noice.config = function()
  require("noice").setup({
    -- :h noice
  })
end

local statusline = {
  "feline-nvim/feline.nvim",
  event = "VimEnter",
}

statusline.config = function()
  local comps = nil
  local cat = package.loaded.catppuccin or pcall(require, "catppuccin")
  if cat then
    comps = require("catppuccin.groups.integrations.feline").get()
  end
  local feline = require "feline"
  feline.setup({  -- TODO: customize this
    components = comps,
  })
  feline.winbar.setup()
end

local icons = {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup()
  end,
}

local screensaver = {
  "folke/drop.nvim",
  -- event = "VimEnter",
  config = function()
    require("drop").setup()
  end,
}

return {
  icons,
  noice,
  statusline,
  screensaver,
}
