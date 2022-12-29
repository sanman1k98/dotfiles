local loaded, catppuccin = pcall(require, "catppuccin")

if not loaded then
  return
end

catppuccin.setup {
  flavour = "mocha",
  integrations = {
    neotree = true,
    which_key = true,
    mini = true,
  },
  compile = {
    enabled = true,
  }
}

catppuccin.load()
