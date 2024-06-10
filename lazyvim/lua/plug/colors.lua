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
        dawnfox = {
          -- Make 'list' characters slightly more visible (default: "bg3")
          WhiteSpace  = { fg = "bg4" },
        },
        all = {
          LspInlayHint = { fg = "bg4", style = "italic" },
          -- Docstrings shouldn't be italicized like regular comments.
          ["@comment.documentation"] = { style = "nocombine" },
          -- By default, luadoc comments link to normal comments.
          ["@comment.luadoc"] = { link = "@comment.documentation" },
          -- Semantic tokens highlights have higher priority, but we can
          -- disable the highlight group for comments only
          ["@lsp.type.comment"] = { style = "NONE" },
        },
      },
    },
  },
}
