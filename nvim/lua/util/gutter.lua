-- copied from folke/dot
local M = {}

M.did_setup = false

---@return {name:string, text:string, texthl:string}[]
function M.get_signs()
  local buf = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  return vim.tbl_map(function(sign)
    return vim.fn.sign_getdefined(sign.name)[1]
  end, vim.fn.sign_getplaced(buf, { group = "*", lnum = vim.v.lnum })[1].signs)
end

-- TODO: refactor this whole thing

function M.eval()
  local sign, git_sign
  for _, s in ipairs(M.get_signs()) do
    if s.name:find("GitSign") then
      git_sign = s
    else
      sign = s
    end
  end

  local number_comp = ""
  local sign_comp = ""
  local git_comp = ""
  local opts = { win = vim.g.statusline_winid }
  local nu = vim.api.nvim_get_option_value("nu", opts)
  local rnu = vim.api.nvim_get_option_value("rnu", opts)
  local signcolumn = vim.api.nvim_get_option_value("scl", opts)
  if nu and rnu and vim.v.virtnum == 0 then
    number_comp = (vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum).." "
  end
  if signcolumn ~= "no" then
    sign_comp = sign and ("%#"..sign.texthl.."#"..sign.text.."%*") or " "
    git_comp = git_sign and ("%#"..git_sign.texthl.."#"..git_sign.text.."%*") or "  "
  end
  local components = {
    sign_comp,
    [[%=]],   -- spacing
    number_comp,
    git_comp,
  }
  return table.concat(components, "")
end

-- TODO: implement some toggles

function M.toggle()
end

function M.setup()
  if M.did_setup then return end
  if vim.fn.has("nvim-0.9.0") == 1 then
    _G.Gutter = M
    vim.go.statuscolumn = [[%!v:lua.Gutter.eval()]]
  end
  M.did_setup = true
end

return M
