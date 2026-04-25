-- Adapted from the Lua module "codecompanion.adapters.http.openai_compatible".

local M = {}

local Curl = require("plenary.curl")
local adapter_utils = require("codecompanion.utils.adapters")
local config = require("codecompanion.config")
local log = require("codecompanion.utils.log")

local _cache_expires
local _cache_file = vim.fn.tempname()
---@type { [string]: { status: "loaded" | "unloaded" } }
local _cached_models

--- Get information about available OpenAI compatible models.
---@params self CodeCompanion.Adapter
function M.get_models(self)
  if _cached_models and _cache_expires and _cache_expires > os.time() then
    return _cached_models
  end

  _cached_models = {}

  local adapter = require("codecompanion.adapters").resolve(self)
  if not adapter then
    log:error("Could not resolve OpenAI compatible adapter in the `fetch_models` function")
    return {}
  end

  adapter_utils.get_env_vars(adapter, { timeout = config.adapters.opts.cmd_timeout })
  local url = adapter.env_replaced.url .. adapter.env_replaced.models_endpoint

  local headers = adapter_utils.set_env_vars(adapter, adapter.headers) or {}

  local ok, response, json

  ok, response = pcall(function()
    return Curl.get(url, {
      sync = true,
      headers = headers,
      insecure = config.adapters.http.opts.allow_insecure,
      proxy = config.adapters.http.opts.proxy,
    })
  end)
  if not ok then
    log:error("Could not get the OpenAI compatible models from " .. url .. ".\nError: %s", response)
    return {}
  end

  ok, json = pcall(vim.json.decode, response.body)
  if not ok then
    log:error("Could not parse the response from " .. url)
    return {}
  end

  for _, model in
    ipairs(json.data --[[@as { id: string, status: { value: "loaded" | "unloaded" } }[] ]])
  do
    if type(model.status) ~= "table" or type(model.status.value) ~= "string" then
      log:error("Could not get status of model " .. model.id)
      return {}
    else
      _cached_models[model.id] = { status = model.status.value }
    end
  end

  _cache_expires =
    adapter_utils.refresh_cache(_cache_file, config.adapters.http.opts.cache_models_for)

  return _cached_models
end

return M
