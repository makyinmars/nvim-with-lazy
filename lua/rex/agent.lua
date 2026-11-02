-- Send context from Neovim to an agent pane in Rex (Claude Code, Codex,
-- OpenCode, Pi, ...): @path#L references, code, diagnostics, git hunks, and
-- quickfix items. Text is pasted into the agent's input and not submitted, so
-- you can add to it there.
--
-- Agents come from Rex's agent_panes action (~/.config/rex/actions/agents.lua),
-- this session's first. With one agent in this session it is used directly;
-- otherwise you pick one, and the pick is remembered until <leader>at.

local rex = require("rex")

local M = {}

local target -- the agent picked last
local warn = vim.log.levels.WARN

local function notify(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = "Rex" })
end

local state_icons = { idle = "●", working = "◉", blocked = "!", done = "✓", error = "✗" }

local function describe(agent)
  local name = agent.title or agent.app
  if agent.label and agent.label ~= "" and agent.label ~= "shell" then
    name = agent.label
  end
  local where = agent.session_id == vim.env.REX_SESSION and "" or ("  · " .. (agent.session_label or "other session"))
  return string.format("%s %s  · %s%s", state_icons[agent.state] or "○", name, agent.app, where)
end

local function fetch(on_agents)
  rex.run({ "do", "agent_panes", "--json" }, nil, function(ok, out, err)
    if not ok then
      return notify("Couldn't list agent panes: " .. vim.trim(err), warn)
    end
    local decoded_ok, decoded = pcall(vim.json.decode, out)
    if not decoded_ok or type(decoded) ~= "table" then
      return notify("Unexpected reply from rex do agent_panes", warn)
    end
    on_agents(decoded.agents or {})
  end)
end

local function choose(force, on_choice)
  fetch(function(agents)
    if #agents == 0 then
      return notify("No agent panes in Rex", warn)
    end
    if not force and target then
      for _, agent in ipairs(agents) do
        if agent.block_id == target.block_id then
          target = agent
          return on_choice(agent)
        end
      end
    end
    local here = vim.tbl_filter(function(agent)
      return agent.session_id == vim.env.REX_SESSION
    end, agents)
    if not force and #here == 1 then
      target = here[1]
      return on_choice(target)
    end
    vim.ui.select(agents, { prompt = "Agent", format_item = describe }, function(choice)
      if choice then
        target = choice
        on_choice(choice)
      end
    end)
  end)
end

local function paste(agent, text)
  local payload = vim.json.encode({
    session_id = agent.session_id,
    block_id = agent.block_id,
    event = { type = "paste", payload = { text = text } },
  })
  rex.run({ "api", "call", "block.event", "-" }, { stdin = payload }, function(ok, _, err)
    if ok then
      notify("Sent to " .. describe(agent))
    else
      target = nil
      notify("Couldn't send: " .. vim.trim(err), warn)
    end
  end)
end

function M.send(text)
  choose(false, function(agent)
    paste(agent, text)
  end)
end

-- The selected lines in visual mode (leaving it), or the cursor's line.
local function range()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    local first, last = vim.fn.line("v"), vim.fn.line(".")
    if first > last then
      first, last = last, first
    end
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
    return first, last, true
  end
  local line = vim.fn.line(".")
  return line, line, false
end

local function path(buf)
  local name = vim.api.nvim_buf_get_name(buf or 0)
  if name == "" then
    return nil
  end
  return vim.fn.fnamemodify(name, ":.")
end

local function reference(file, first, last)
  if first == last then
    return string.format("@%s#L%d", file, first)
  end
  return string.format("@%s#L%d-L%d", file, first, last)
end

local function code(first, last)
  local lines = vim.api.nvim_buf_get_lines(0, first - 1, last, false)
  return string.format("```%s\n%s\n```", vim.bo.filetype, table.concat(lines, "\n"))
end

local function require_file()
  local file = path()
  if file == nil then
    notify("This buffer has no file", warn)
  end
  return file
end

function M.reference()
  local first, last = range()
  local file = require_file()
  if file then
    M.send(reference(file, first, last) .. " ")
  end
end

function M.reference_with_code()
  local first, last = range()
  local file = require_file()
  if file then
    M.send(reference(file, first, last) .. "\n" .. code(first, last) .. "\n")
  end
end

function M.prompt()
  local first, last, visual = range()
  local file = require_file()
  if file == nil then
    return
  end
  local context = reference(file, first, last)
  if visual then
    context = context .. "\n" .. code(first, last)
  end
  vim.ui.input({ prompt = "Ask agent: " }, function(input)
    if input and input ~= "" then
      M.send(context .. "\n\n" .. input)
    end
  end)
end

function M.diagnostics()
  local first, last, visual = range()
  local file = require_file()
  if file == nil then
    return
  end
  local lines = {}
  for _, item in ipairs(vim.diagnostic.get(0)) do
    local line = item.lnum + 1
    if not visual or (line >= first and line <= last) then
      local severity = vim.diagnostic.severity[item.severity] or "INFO"
      local source = item.source and (" (" .. item.source .. ")") or ""
      table.insert(lines, string.format("%s: %s %s%s", reference(file, line, line), severity, item.message, source))
    end
  end
  if #lines == 0 then
    return notify("No diagnostics here")
  end
  M.send("Diagnostics:\n" .. table.concat(lines, "\n") .. "\n")
end

-- The function, method, or class around the cursor, found with Treesitter.
local symbol_types = { "function", "method", "class", "struct", "impl", "interface", "enum", "module" }

function M.symbol()
  local file = require_file()
  local ok, node = pcall(vim.treesitter.get_node)
  if file == nil or not ok then
    return
  end
  while node do
    local kind = node:type()
    for _, wanted in ipairs(symbol_types) do
      if kind:find(wanted, 1, true) and not kind:find("call", 1, true) then
        local first, _, last = node:range()
        return M.send(reference(file, first + 1, last + 1) .. "\n" .. code(first + 1, last + 1) .. "\n")
      end
    end
    node = node:parent()
  end
  notify("No function or class around the cursor", warn)
end

-- The git hunk under the cursor, from gitsigns.
function M.hunk()
  local file = require_file()
  local ok, gitsigns = pcall(require, "gitsigns")
  if file == nil or not ok then
    return
  end
  local line = vim.fn.line(".")
  for _, hunk in ipairs(gitsigns.get_hunks(0) or {}) do
    local first = hunk.added.start
    local last = first + math.max(hunk.added.count, 1) - 1
    if line >= first and line <= last then
      return M.send(reference(file, first, last) .. "\n```diff\n" .. table.concat(hunk.lines, "\n") .. "\n```\n")
    end
  end
  notify("No git hunk under the cursor", warn)
end

local function send_list(items, name)
  local lines = {}
  for _, item in ipairs(items) do
    local file = item.bufnr > 0 and path(item.bufnr)
    if file then
      table.insert(lines, string.format("%s: %s", reference(file, item.lnum, item.lnum), vim.trim(item.text)))
    end
  end
  if #lines == 0 then
    return notify("The " .. name .. " is empty")
  end
  M.send(table.concat(lines, "\n") .. "\n")
end

function M.quickfix()
  send_list(vim.fn.getqflist(), "quickfix list")
end

function M.location_list()
  send_list(vim.fn.getloclist(0), "location list")
end

function M.pick()
  choose(true, function(agent)
    notify("Sending to " .. describe(agent))
  end)
end

function M.focus()
  choose(false, function(agent)
    rex.run({ "do", "focus_pane", "block_id=" .. agent.block_id, "session_id=" .. agent.session_id })
  end)
end

function M.setup()
  local maps = {
    { "<leader>ay", M.reference, { "n", "x" }, "Send @path#L Reference" },
    { "<leader>aY", M.reference_with_code, { "n", "x" }, "Send Reference and Code" },
    { "<leader>ap", M.prompt, { "n", "x" }, "Ask Agent About Line or Selection" },
    { "<leader>ad", M.diagnostics, { "n", "x" }, "Send Diagnostics" },
    { "<leader>as", M.symbol, "n", "Send Current Symbol" },
    { "<leader>ah", M.hunk, "n", "Send Git Hunk" },
    { "<leader>aq", M.quickfix, "n", "Send Quickfix List" },
    { "<leader>al", M.location_list, "n", "Send Location List" },
    { "<leader>at", M.pick, "n", "Pick Agent" },
    { "<leader>aa", M.focus, "n", "Go to Agent Pane" },
  }
  for _, map in ipairs(maps) do
    vim.keymap.set(map[3], map[1], map[2], { desc = map[4] })
  end
  local ok, which_key = pcall(require, "which-key")
  if ok then
    which_key.add({ { "<leader>a", group = "agent (Rex)", mode = { "n", "x" } } })
  end
end

return M
