-- Rex integration (https://www.superlogical.com/rex), paired with ~/.config/rex.
-- Everything here is a no-op outside Rex and under neorex.
--
-- - status.lua:   reports Neovim to Rex (OSC 7501), so Rex can tell it apart.
-- - navigate.lua: one grid for splits and Rex panes (Rex's Leader h/j/k/l).
-- - agent.lua:    sends references, code, and diagnostics to agent panes.
-- - open():       Rex's open_location action opens files here through a socket.

local M = {}

function M.in_neorex()
  return vim.v.servername:match("/neorex%-%d+%.nvim%.sock$") ~= nil
end

function M.active()
  return vim.env.REX_BLOCK ~= nil and vim.env.REX_SESSION ~= nil and not M.in_neorex() and #vim.api.nvim_list_uis() > 0
end

function M.bin()
  local dir = vim.env.REX_BIN_DIR
  if dir and vim.fn.executable(dir .. "/rex") == 1 then
    return dir .. "/rex"
  end
  return "rex"
end

--- Run the rex CLI without blocking. on_done(ok, stdout, stderr) runs on the main loop.
---@param args string[]
---@param opts? { stdin?: string }
---@param on_done? fun(ok: boolean, stdout: string, stderr: string)
function M.run(args, opts, on_done)
  local cmd = { M.bin() }
  vim.list_extend(cmd, args)
  local ok, err = pcall(vim.system, cmd, { text = true, stdin = opts and opts.stdin }, function(result)
    if on_done then
      vim.schedule(function()
        on_done(result.code == 0, result.stdout or "", result.stderr or "")
      end)
    end
  end)
  if not ok and on_done then
    on_done(false, "", tostring(err))
  end
end

-- The socket Rex's open_location action reaches this Neovim through. Rex
-- derives the same path from the pane's block ID (lib/common.lua).
function M.socket_path()
  local tmp = (vim.env.TMPDIR or "/tmp"):gsub("/$", "")
  return string.format("%s/nvim-rex-%s.sock", tmp, vim.env.REX_BLOCK:sub(-12))
end

local function start_server()
  local path = M.socket_path()
  if vim.tbl_contains(vim.fn.serverlist(), path) then
    return
  end
  if vim.uv.fs_stat(path) then
    -- Another Neovim in this pane owns it (one started from a :terminal), or
    -- a crashed one left it behind.
    local ok, chan = pcall(vim.fn.sockconnect, "pipe", path, { rpc = true })
    if ok and chan > 0 then
      vim.fn.chanclose(chan)
      return
    end
    os.remove(path)
  end
  pcall(vim.fn.serverstart, path)
end

--- Open a file at a position. Rex calls this through the socket:
---   nvim --server SOCKET --remote-expr "v:lua.require'rex'.open('path', line, col)"
function M.open(file, line, col)
  vim.schedule(function()
    vim.cmd.stopinsert()
    -- Leave floating windows such as pickers.
    if vim.api.nvim_win_get_config(0).relative ~= "" then
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(win).relative == "" then
          vim.api.nvim_set_current_win(win)
          break
        end
      end
    end
    vim.cmd.edit(vim.fn.fnameescape(file))
    pcall(vim.api.nvim_win_set_cursor, 0, { line or 1, math.max((col or 1) - 1, 0) })
    vim.cmd("normal! zz")
  end)
  return true
end

function M.setup()
  if not M.active() then
    return
  end
  start_server()
  require("rex.status").setup()
  require("rex.navigate").setup()
  require("rex.agent").setup()
end

return M
