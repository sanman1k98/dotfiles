local map = vim.keymap

map.set("i", "kj", "<esc>", { desc = "ESC" })
map.set("i", "<c-f>", "<right>", { desc = "->" })
map.set("i", "<c-b>", "<left>", { desc = "<-" })

map.set("n", "<d-s>", vim.cmd.write, { desc = "Save file" })
