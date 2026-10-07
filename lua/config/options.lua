-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Make Mason-installed tools available before lazy-loaded plugins initialize.
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
if not vim.env.PATH:find(mason_bin, 1, true) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

-- No remote plugins are used (rplugin is disabled in lazy.lua), so skip the language providers.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
vim.g.snacks_animate = false

-- Dedicated formatters own formatting; ESLint still provides diagnostics and code actions.
vim.g.lazyvim_eslint_auto_format = false
