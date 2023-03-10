local say = require "say"

local function contains(state, args)
  local list, values = args[1], args[2]
  if not vim.tbl_islist(list) then return false end
  if not vim.tbl_islist(values) then values = { values } end
  local counted = {}
  for _, item in ipairs(values) do
    local found = false
    for i, v in ipairs(list) do
      if not counted[i] and vim.deep_equal(item, v) then
        counted[i] = true
        found = true
      end
    end
    if not found then return false end
  end
  return true
end

say:set("assertion.contains.positive", "Expected %s to contain value(s): %s")
say:set("assertion.contains.negative", "Expected %s to not contain value(s): %s")
assert:register("assertion", "contains", contains, "assertion.contains.positive", "assertion.contains.negative")
