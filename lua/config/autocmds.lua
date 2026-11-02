-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Rex integration (lua/rex): status reporting, split/pane navigation, and sending context to agents.
-- Does nothing outside Rex.
require("rex").setup()
