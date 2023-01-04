-- TODO create my own components
return function()
  local comps = require("catppuccin.groups.integrations.feline").get()
  require("feline").setup {
    components = comps
  }
end
