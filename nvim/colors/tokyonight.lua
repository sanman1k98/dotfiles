vim.cmd.packadd "tokyonight.nvim"

local loaded, tokyonight = pcall(require, "tokyonight.colors")

if not loaded then
  return
end

local g = vim.g
g.tokyonight_style = "night"
g.tokyonight_day_brightness = 0.7
g.tokyonight_sidebars = {
  "qf",
  "packer",
  "NvimTree",
  "terminal",
}

-- TODO use the tokyonight module to set highlight groups for telescope

vim.cmd.colorscheme "tokyonight"
