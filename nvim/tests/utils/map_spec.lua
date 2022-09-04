
describe("Builtin keymap APIs", function()
  local keymap = vim.keymap

  it("Sets a keymapping", function()
    keymap.set("n", "hi", function()
      print "Hello!"
    end)
  end)

end)
