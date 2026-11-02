-- One grid for Neovim splits and Rex panes, like vim-tmux-navigator.
--
-- Rex's Leader h/j/k/l (and Cmd+Alt+arrows) run its navigate action. In a pane
-- running this Neovim, that action sends F13-F16 here instead of moving Rex's
-- focus. These mappings move to the split in that direction, and at the edge
-- hand focus back to Rex with `rex focus DIRECTION --wrap`.

local rex = require("rex")

local M = {}

local keys = { ["<F13>"] = "h", ["<F14>"] = "j", ["<F15>"] = "k", ["<F16>"] = "l" }
local directions = { h = "left", j = "down", k = "up", l = "right" }

function M.go(key)
  local win = vim.api.nvim_get_current_win()
  pcall(vim.cmd.wincmd, key)
  if vim.api.nvim_get_current_win() == win then
    rex.run({ "focus", directions[key], "--wrap" })
  end
end

function M.setup()
  for lhs, key in pairs(keys) do
    vim.keymap.set({ "n", "i", "x", "t" }, lhs, function()
      M.go(key)
    end, { desc = "Focus Split or Rex Pane " .. directions[key] })
  end
end

return M
