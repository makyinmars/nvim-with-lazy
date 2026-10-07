# Maky Personal Config

A personal [LazyVim](https://www.lazyvim.org/)-based Neovim setup focused on TypeScript, Python, Markdown, AI-assisted development, and fast Git workflows.

## Highlights

- **Completion:** Blink with snippets and signature help; Noice handles hover, messages, and the command line
- **Navigation and editing:** Snacks picker/explorer, Flash, Spider subword motions, TreeSJ, Mini Surround, Mini Move, and Yanky
- **Code intelligence:** LSP support for TypeScript 7 (`tsc`), Python, JSON, Markdown, TOML, and shell/dotfiles
- **Code quality:** project-local Oxlint and Oxfmt in OXC projects, with Biome and ESLint available for other projects
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
- Mason installs TypeScript 7 (`tsc`) for its native language server. Project-local TypeScript 7+ takes priority; older compilers fall back to Mason's version.

Optional integrations:

- Set `HERDR_ENV=1` when running inside Herdr to enable `herdr-context.nvim`.
- Set `YOUTUBE_API_KEY` to use the YouTube Music provider in Jam.
- Local plugins are enabled only when their directories exist:
  - `~/Development/NVIM/amp-orbs.nvim`
  - `~/Development/NVIM/jam.nvim`
  - `~/Development/NVIM/herdr-context.nvim` (also requires `HERDR_ENV=1`)

## Installation

```sh
git clone <repository-url> ~/.config/nvim
nvim --headless "+Lazy! restore" +qa
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
| `<leader>zf` | Create a fold from a visual selection; switches the current window to manual folding |
| `<leader>cr` | Incremental LSP rename |
| `<leader>sr` | Search and replace with Grug Far |
| `<leader>gv` | Open CodeDiff for working-tree changes |
| `<leader>gV` | Open CodeDiff Git history |
| `<leader>ghs` | Stage the current Git hunk |
| `<leader>ghr` | Reset the current Git hunk |
| `<leader>me` | Toggle the MDEye Markdown view |
| `<leader>ac` | Compose Herdr context (stacked agent / message / references / preview) |
| `<leader>ap` | Prompt Herdr with the current line or Visual selection |
| `<leader>ay` | Stage an `@path#L…` reference without embedding code |
| `<leader>aa` | Toggle the Herdr agent drawer |
| `<leader>jm` | Search YouTube Music with Jam |
| `<leader>ao` | View Amp Orbs |

Inside the Herdr composer: `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` move between stacked panes; `1`–`9` pick a live agent; `<Space>` attaches or detaches a reference; `e` embeds that snippet; `s` stages and `S` / `<C-Enter>` send. Press `?` in the composer for the full key list.

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
nvim --headless "+checkhealth" +qa
git diff --check
```

Use `:Lazy restore` to restore pinned plugin versions. Use `:Lazy sync` when you intend to install, remove, and update plugins and refresh the lockfile.

In OXC projects such as Cima, Oxfmt is the sole Conform formatter and Oxlint uses the repository's lint config. The Oxfmt language server and ESLint auto-formatting are disabled to avoid duplicate formatting. ESLint still provides diagnostics and code actions where configured. Outside configured Oxfmt projects, the existing formatter selection applies.

Inside Neovim, use `:Lazy` for plugin management, `:Mason` for external editor tooling, and `:checkhealth` for diagnostics.

## License

[MIT](LICENSE)
