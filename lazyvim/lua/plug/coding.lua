local map = require("util.map")

return {
  -- split/join
  {
    "Wansmer/treesj",
    opts = function ()
      local lang_utils = require("treesj.langs.utils")
      local html = require("treesj.langs.html")
      local ts = require("treesj.langs.typescript")

      local langs = {
        astro = lang_utils.merge_preset(html, ts)
      }

      return {
        use_default_keymaps = false,
        max_join_length = 150,
        langs = langs,
      }
    end,
    keys = map.lazykeys {
      prefix = "<leader>j",
      label = "split/join",
      { "j", function() require("treesj").toggle() end, desc = "Toggle split" },
    },
  },
}
