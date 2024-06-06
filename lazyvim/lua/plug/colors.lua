return {

  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    opts = {
      options = {
        styles = {
          constants = "bold",
          comments = "italic",
        },
      },
      groups = {
        all = {
          LspInlayHint = { fg = "bg4", style = "italic" },
          -- Docstrings shouldn't be italicized like regular comments.
          ["@comment.documentation"] = { style = "nocombine" },
        },
      },
    },
  },
}
