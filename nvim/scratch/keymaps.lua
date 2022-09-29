
vim.keymap.set("n", "<leader>hi", function()
  vim.notify("Hello!")
end, {
  desc = "print hello"
})



vim.keymap.set("n", "<leader>bye", function()
  vim.pretty_print("Goodbye!")
  vim.defer_fn(function()
    vim.cmd.quitall()
  end, 5000)
end)



vim.keymap.set("n", "<leader>so", function()
  vim.cmd.source()
  vim.notify("Sourced " .. vim.api.nvim_buf_get_name(0))
end)


vim.keymap.set("v", "<leader>so", function()
  vim.cmd.source {
    range = { vim.fn.line("."), vim.fn.line("v") },
  }
  vim.notify "Sourced selection"
end)

vim.notify("yoyoyoyoy")

vim.keymap.set("n", "<leader>lc", function()
  vim.opt.list = not vim.opt.list:get()
end)
