# Maky Personal Config

A personal [LazyVim](https://www.lazyvim.org/)-based Neovim setup focused on TypeScript, Python, Markdown, AI-assisted development, and fast Git workflows.

## Highlights

- **Completion:** Blink with snippets, signature help, and Supermaven suggestions
- **Navigation and editing:** Snacks picker/explorer, Flash, Spider subword motions, TreeSJ, Mini Surround, Mini Move, and Yanky
- **Code intelligence:** LSP support for TypeScript (`tsgo`), Python, JSON, Markdown, TOML, and shell/dotfiles
- **Refactoring:** incremental rename, Tree-sitter refactors, and code-action indicators
- **Git:** Gitsigns for hunks and blame, plus CodeDiff for repository diffs and history
- **Debugging:** DAP with UI, virtual text, and Python/JavaScript adapters
- **Markdown:** in-buffer rendering with `render-markdown.nvim` and document views with MDEye
- **AI context:** Herdr integration and reference-aware yanks for coding agents
- **Personal plugins:** Amp Orbs and Jam/YouTube Music integrations

## Requirements

- Neovim 0.12+
- Git, `rg`, `fd`, `fzf`, and `lazygit`
- A Nerd Font
- `chafa` for the dashboard image
- Language runtimes and tools for the projects you edit; Mason manages most editor tooling

Optional integrations:

- Set `HERDR_ENV=1` when running inside Herdr to enable `herdr-context.nvim`.
- Set `YOUTUBE_API_KEY` to use the YouTube Music provider in Jam.
- The local plugins expect these directories to exist:
  - `~/Development/NVIM/amp-orbs.nvim`
  - `~/Development/NVIM/jam.nvim`

## Installation

```sh
git clone <repository-url> ~/.config/nvim
nvim --headless "+Lazy! sync" +qa
```

Then launch Neovim normally:

```sh
nvim
```

## Notable Keymaps

`<leader>` is Space.

| Key | Action |
| --- | --- |
| `kj` / `jk` | Leave Insert mode |
| `w`, `e`, `b`, `ge` | Move by subword with Spider |
| `<leader>cj` | Split or join the code block under the cursor |
| `<leader>cJ` | Recursively split or join a code block |
| `<leader>cr` | Incremental LSP rename |
| `<leader>sr` | Search and replace with Grug Far |
| `<leader>gv` | Open CodeDiff for working-tree changes |
| `<leader>gV` | Open CodeDiff Git history |
| `<leader>ghs` | Stage the current Git hunk |
| `<leader>ghr` | Reset the current Git hunk |
| `<leader>me` | Toggle the MDEye Markdown view |
| `<leader>ac` | Compose Herdr context |
| `<leader>ap` | Prompt Herdr with code context |
| `<leader>jm` | Search YouTube Music with Jam |
| `<leader>ao` | View Amp Orbs |

Use `<leader>?` to inspect buffer-local mappings and `:LazyExtras` to review enabled LazyVim extras.

## Structure

```text
init.lua             Entry point
lua/config/          Core options, keymaps, autocmds, and lazy.nvim setup
lua/plugins/         Plugin specs and LazyVim overrides
lazyvim.json         Enabled LazyVim extras
lazy-lock.json       Pinned plugin revisions
assets/              Dashboard image and helper script
```

## Maintenance

```sh
stylua .
stylua --check .
nvim --headless "+Lazy! sync" +qa
nvim --headless "+checkhealth" +qa
git diff --check
```

Inside Neovim, use `:Lazy` for plugin management, `:Mason` for external editor tooling, and `:checkhealth` for diagnostics.

## License

[MIT](LICENSE)
