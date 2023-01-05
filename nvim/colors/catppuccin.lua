local loaded, catppuccin = pcall(require, "catppuccin")

if not loaded then
  return
end

catppuccin.setup {
  flavour = "mocha",
  integrations = {
    bufferline = true,
    mason = true,
    neotree = true,
    neogit = true,
    noice = true,
    notify = true,
    which_key = true,
    mini = true,
  },
}

catppuccin.load()
