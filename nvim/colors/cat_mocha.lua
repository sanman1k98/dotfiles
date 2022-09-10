vim.cmd.packadd { "catppuccin", bang = true }

local loaded, catppuccin = pcall(require, "catppuccin")

if not loaded then
  return
end

vim.g.catppuccin_flavour = "mocha"

catppuccin.setup {
  compile = {
    enabled = true,
    path = vim.fn.stdpath("cache") .. "/catpuccin",
  }
}

-- TODO set telescope highlight groups for borderless look

vim.cmd.runtime "colors/catppuccin.lua"
