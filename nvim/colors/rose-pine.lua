local loaded, rose = pcall(require, "rose-pine")

if not loaded then
  return
end

rose.setup {
  -- configuration
}

rose.colorscheme()
