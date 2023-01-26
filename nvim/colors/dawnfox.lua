local fox = require "nightfox"

fox.setup({
  options = {
    styles = {
      comments = "italic",
    },
  },
  -- TODO: set telescope highlights for that borderless look
  groups = {
    dawnfox = {
      WhiteSpace  = { fg = "bg4" },    -- make 'list' characters slightly more visible (default: "bg3")
    },
  },
})

require("nightfox.config").set_fox("dawnfox")
fox.load()
