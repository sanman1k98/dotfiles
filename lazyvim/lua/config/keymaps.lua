local map = require("util.map")

map.set {
  {
    mode = "i",
    { "kj", "<esc>", desc = "ESC" },
    { "<c-f>", "<right>", desc = "->" },
    { "<c-b>", "<left>", desc = "<-" },
  },
  {
    mode = { "i", "x", "n", "s" },
    { "<c-s>", false },
    { "<d-s>", "<cmd>w<cr><esc>", desc = "Write file" },
  },
}
