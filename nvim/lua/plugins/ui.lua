local noice = {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  event = "VimEnter",
}

noice.config = function()
  require("noice").setup {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      lsp_doc_border = false,
    },
  }
end

local bufferline = {
  "akinsho/bufferline.nvim",
  -- event = "VeryLazy",
}

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

local dashboard = {
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
  bufferline,
  dashboard,
}
