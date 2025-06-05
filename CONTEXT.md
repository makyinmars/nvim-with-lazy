# Neovim Configuration Context

## Build/Lint/Test Commands
- **Format Lua**: `stylua .` (uses stylua.toml config: 2 spaces, 120 column width)
- **Check syntax**: Open nvim and use `:checkhealth` for diagnostics
- **Plugin management**: `:Lazy` for plugin operations, `:LazyExtras` for extras
- **No traditional tests** - this is a Neovim configuration, not a software project

## Code Style Guidelines
- **Language**: Lua for Neovim configuration
- **Indentation**: 2 spaces (enforced by stylua.toml)
- **Line length**: 120 characters max
- **Imports**: Use `require("module")` at top of functions/configs, not file-level
- **Plugin structure**: Return table from plugin files in `lua/plugins/`
- **Comments**: Use `--` for single line, descriptive comments for complex configs
- **Naming**: snake_case for variables, kebab-case for plugin file names
- **Error handling**: Use `pcall()` for optional plugin loading
- **Keymaps**: Use descriptive `desc` field, follow `<leader>` prefix conventions
- **Config organization**: 
  - `lua/config/` for core Neovim settings
  - `lua/plugins/` for individual plugin configurations
  - Each plugin in separate file returning configuration table
- **LazyVim conventions**: Follow LazyVim patterns for plugin specs and keymaps