-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- In case you don't want to use `:LazyExtras`,
-- then you need to set the option below.

vim.g.lazyvim_ts_lsp = "tsgo"

-- Make Mason-installed tools available before lazy-loaded plugins initialize.
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if not vim.env.PATH:find(mason_bin, 1, true) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
vim.g.snacks_animate = false
