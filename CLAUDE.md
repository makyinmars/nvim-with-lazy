# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **LazyVim-based Neovim configuration** built on the lazy.nvim plugin manager. The configuration follows a modular architecture where each plugin is configured in its own file.

## Essential Commands

### Formatting and Linting
```bash
stylua .        # Format all Lua code (2 spaces, 120 char width)
```

### Development and Testing
```vim
:checkhealth    # Comprehensive health diagnostics
:Lazy           # Plugin manager interface
:LazyExtras     # Enable/disable LazyVim extras
:LazyUpdate     # Update all plugins
```

## Architecture and Code Organization

### Directory Structure
- **`init.lua`**: Entry point that requires `config.lazy`
- **`lua/config/`**: Core Neovim configuration
  - `lazy.lua` - Plugin manager setup
  - `options.lua` - Neovim settings
  - `keymaps.lua` - Custom keybindings
  - `autocmds.lua` - Autocommands
- **`lua/plugins/`**: Individual plugin configurations (each plugin in separate file)
- **`lazyvim.json`**: LazyVim extras configuration
- **`lazy-lock.json`**: Locked plugin versions

### Plugin Configuration Pattern
All plugins in `lua/plugins/` follow this structure:
```lua
return {
  "plugin/name",
  event = "VeryLazy",        -- lazy loading trigger
  dependencies = { ... },
  opts = { ... },            -- plugin options
  config = function() ... end,
  keys = {                   -- keybindings with descriptions
    { "<leader>x", function() ... end, desc = "Description" }
  }
}
```

### LazyVim Integration
- Base configuration imports `lazyvim.plugins`
- Custom plugins in `lua/plugins/` override/extend LazyVim defaults
- Enabled extras: nvim-cmp, telescope, python language support
- Uses LazyVim's conventions for keymaps and plugin specs

## Code Style Guidelines

- **Indentation**: 2 spaces (enforced by stylua.toml)
- **Line length**: 120 characters max
- **Naming**: snake_case for variables, kebab-case for plugin files
- **Error handling**: Use `pcall()` for optional plugin loading
- **Keymaps**: Always include descriptive `desc` field
- **Comments**: Use `--` for single line, descriptive comments for complex configs

## Key Architectural Patterns

### Plugin Loading Strategy
- LazyVim plugins are lazy-loaded by default
- Custom plugins load during startup unless explicitly configured otherwise
- Performance optimizations disable unnecessary runtime plugins

### Configuration Management
- Each plugin configuration is self-contained in its own file
- Shared settings go in `lua/config/`
- Plugin-specific keybindings defined within plugin specs
- Use `opts` table for simple configurations, `config` function for complex setup

### AI/LLM Integration
This config includes multiple AI tools:
- Avante.nvim for multi-provider AI assistance
- Supermaven for AI code completion
- Multiple LLM provider configurations with fallbacks

## Development Workflow

1. **Adding plugins**: Create new file in `lua/plugins/` returning config table
2. **Modifying settings**: Edit files in `lua/config/`
3. **Testing changes**: Use `:source %` and `:checkhealth`
4. **Before committing**: Run `stylua .` to format code
