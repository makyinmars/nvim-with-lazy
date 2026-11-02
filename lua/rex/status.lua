-- Reports Neovim to Rex with the Program Status Protocol (OSC 7501):
-- https://www.superlogical.com/rex/docs/build/program-status
--
-- The record (id=nvim, app=nvim) is how Rex's navigate action recognizes this
-- Neovim. It is idle with the current file as its message, working while a
-- language server reports progress for more than a moment, and cleared on
-- exit or suspend. Activity shows it with "show idle processes" on.

local M = {}

local last_sent
local progress = {} -- "client:token" -> { client, title, message, percentage, since }
local timer

local function send(state, fields)
  local parts = { "state=" .. state, "id=nvim" }
  if state ~= "clear" then
    table.insert(parts, "app=nvim")
    if fields and fields.progress then
      table.insert(parts, "progress=" .. math.max(0, math.min(100, math.floor(fields.progress))))
    end
    if fields and fields.msg and fields.msg ~= "" then
      local msg = vim.fn.strcharpart(fields.msg:gsub("%c", " "), 0, 160)
      table.insert(parts, "msg=" .. vim.base64.encode(msg))
    end
  end
  local sequence = "\27]7501;" .. table.concat(parts, ":") .. "\27\\"
  if sequence ~= last_sent then
    last_sent = sequence
    pcall(vim.api.nvim_ui_send, sequence)
  end
end

local function current_file()
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" or vim.bo.buftype ~= "" then
    return vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
  end
  return vim.fn.fnamemodify(name, ":~:.")
end

local function refresh()
  local now = vim.uv.now()
  for _, item in pairs(progress) do
    if now - item.since >= 800 then
      local msg = item.client .. ": " .. item.title .. (item.message and (" " .. item.message) or "")
      send("working", { progress = item.percentage, msg = msg })
      return
    end
  end
  send("idle", { msg = current_file() })
end

local function refresh_soon(delay)
  timer:stop()
  timer:start(delay or 200, 0, vim.schedule_wrap(refresh))
end

function M.setup()
  if not vim.api.nvim_ui_send then
    return
  end
  timer = assert(vim.uv.new_timer())
  local group = vim.api.nvim_create_augroup("rex_status", { clear = true })

  vim.api.nvim_create_autocmd("LspProgress", {
    group = group,
    callback = function(ev)
      local params = ev.data and ev.data.params
      local value = params and params.value
      if type(value) ~= "table" then
        return
      end
      local key = ev.data.client_id .. ":" .. tostring(params.token)
      if value.kind == "begin" then
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        progress[key] = {
          client = client and client.name or "lsp",
          title = value.title or "",
          message = value.message,
          percentage = value.percentage,
          since = vim.uv.now(),
        }
        vim.defer_fn(refresh, 900)
      elseif value.kind == "report" and progress[key] then
        progress[key].message = value.message or progress[key].message
        progress[key].percentage = value.percentage or progress[key].percentage
      elseif value.kind == "end" then
        progress[key] = nil
      end
      refresh_soon()
    end,
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
    group = group,
    callback = function()
      refresh_soon()
    end,
  })

  vim.api.nvim_create_autocmd({ "VimLeavePre", "VimSuspend" }, {
    group = group,
    callback = function()
      send("clear")
    end,
  })

  vim.api.nvim_create_autocmd("VimResume", {
    group = group,
    callback = function()
      last_sent = nil
      refresh()
    end,
  })

  refresh()
end

return M
