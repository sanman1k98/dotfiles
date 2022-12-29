local submods = require("util.mod").submods()

return submods

-- Note: calling `require` in return statement will not work! This is because
-- when `util.mod.submods()` calls `debug.getinfo()` to get the path to this
-- file, the "source" field will be "[C]".
