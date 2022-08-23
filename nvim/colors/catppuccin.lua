vim.cmd.packadd "catppuccin"

local loaded, catppuccin = pcall(require, "catppuccin")

if not loaded then
  return
end

local flavors = {
	"latte",
	"frappe",
	"macchiato",
	"mocha"
}

vim.g.catppuccin_flavour = flavors[4]

catppuccin.setup()

-- TODO set telescope highlight groups for borderless look

vim.cmd.colorscheme "catppuccin"
