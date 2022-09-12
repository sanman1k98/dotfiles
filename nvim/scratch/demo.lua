
vim.keymap.set("n", "<leader>hi", function()
  vim.pretty_print("Hello!")
end, {
  desc = "print hello"
})



vim.keymap.set("n", "<leader>bye", function()
  vim.pretty_print("Goodbye!")
  vim.defer_fn(function()
    vim.cmd "qa"
  end, 5000)
end)



vim.keymap.set("n", "<leader>so", function()
  vim.cmd.source "%"
end)
