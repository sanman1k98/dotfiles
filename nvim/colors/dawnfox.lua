local fox = require "nightfox"

fox.setup({
  options = {
    styles = {
      comments = "italic",
    },
  },
  groups = {
    dawnfox = {
      WhiteSpace  = { fg = "bg4" },    -- make 'list' characters slightly more visible (default: "bg3")
      EndOfBuffer = { fg = "fg3" },    -- show filler lines after the end of the buffer (default: "bg1" which is the background)
    },
  },
})

require("nightfox.config").set_fox("dawnfox")
fox.load()
