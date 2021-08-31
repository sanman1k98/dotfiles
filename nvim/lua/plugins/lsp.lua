local ls = require'lspconfig'

local sumneko_root_path = vim.fn.stdpath('data')..'/site/language-servers/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/macOS/lua-language-server"

local luadev = require'lua-dev'.setup {
	lspconfig = {
		cmd = { sumneko_binary, "-E", sumneko_root_path.."/main.lua" }
	}
}

ls.sumneko_lua.setup( luadev )

-- Deno typescript language server
ls.denols.setup{}

-- Dockerfile language server
ls.dockerls.setup{}

-- Python language server
ls.pyright.setup{}

-- yaml landguage server
ls.yamlls.setup{}
