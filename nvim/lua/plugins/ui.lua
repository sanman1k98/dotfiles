local deps = {
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
}

local plugin = {
  "folke/noice.nvim",
  event = "VimEnter",
}

plugin.config = function()
  require("noice").setup({
    -- :h noice
  })
end

local spec = { unpack(deps) }
spec[#spec + 1] = plugin
return spec
