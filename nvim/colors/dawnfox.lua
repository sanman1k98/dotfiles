require("nightfox.config").set_fox("dawnfox")
local fox = require "nightfox"

fox.setup({
  options = {
    styles = {
      comments = "italic",
    }
  }
})

fox.load()
