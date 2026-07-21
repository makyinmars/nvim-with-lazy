# Repository Guidelines

## Project Structure & Module Organization

This repository is a LazyVim-based Neovim configuration.

- `init.lua`: entry point; loads `lua/config/lazy.lua`.
- `lua/config/`: core configuration (`options.lua`, `keymaps.lua`, `autocmds.lua`, `lazy.lua`).
- `lua/plugins/`: plugin specs and overrides; keep one plugin (or tightly related set) per file.
- `assets/`: supporting scripts and images.
- `lazy-lock.json`: pinned plugin versions.
- `lazyvim.json`: enabled LazyVim extras.
- `stylua.toml`: formatting rules.

## Build, Test, and Development Commands

- `nvim`: launch Neovim with this config.
- `stylua .`: format all Lua files (2 spaces, 120-column width).
- `nvim --headless "+Lazy! sync" +qa`: sync plugins from the lockfile/specs.
- `nvim --headless "+checkhealth" +qa`: run health checks in CI-friendly mode.
- Inside Neovim: `:Lazy` (plugin UI), `:LazyExtras` (extras management), `:checkhealth` (diagnostics).

## Coding Style & Naming Conventions

- Language: Lua.
- Indentation: 2 spaces; line length: 120 (`stylua.toml`).
- Use `require("module.path")` imports and keep config modular.
- Plugin files in `lua/plugins/` use kebab-case names (for example, `rust-analyzer.lua`).
- Use `snake_case` for local identifiers.
- Plugin specs should return Lua tables and include `desc` for keymaps.
- Prefer `pcall(...)` for optional dependencies/features.

## Testing Guidelines

There is no unit-test suite in this repo. Validate changes with:

1. `stylua .`
2. `nvim --headless "+checkhealth" +qa`
3. Manual verification in Neovim for the affected plugin/keymap/workflow.

When changing plugin behavior, test startup and the exact command/key path you touched.

## Commit & Pull Request Guidelines

Recent history uses short messages like `update` and `wip`. Keep subjects concise, but use clear imperative scope when possible:

- `feat(plugins): add blink completion source`
- `fix(keymaps): avoid <leader> conflict`

PRs should include:

- What changed and why.
- Files/modules touched.
- Manual validation steps run.
- Screenshots or clips only for visible UI/theme changes.
- Linked issue/context when relevant.
