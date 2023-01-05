local loaded, tokyonight = pcall(require, "tokyonight")

if not loaded then
  return
end

tokyonight.setup {
  style = "moon",
}

tokyonight.load()
