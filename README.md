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
- **AI context:** Rex integration and reference-aware yanks for coding agents
- **Personal plugins:** MDEye and the Jam/YouTube Music integration

## Requirements

- Neovim 0.12+
- Git, `rg`, `fd`, `fzf`, and `lazygit`
- A Nerd Font
- `chafa` for the dashboard image
- Language runtimes and tools for the projects you edit; Mason manages most editor tooling
- Mason installs TypeScript 7 (`tsc`) for its native language server. Project-local TypeScript 7+ takes priority; older compilers fall back to Mason's version.

Optional integrations:

- Set `YOUTUBE_API_KEY` to use the YouTube Music provider in Jam.
- The Rex integration in `lua/rex/` is active when the `rex` CLI is on `PATH`.
- Local plugins are enabled only when their directories exist:
  - `~/Development/NVIM/mdeye.nvim`
  - `~/Development/NVIM/jam.nvim`

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
| `<leader>mz` | Zoom and pan the image under the MDEye preview cursor (`gz` inside the preview) |
| `<leader>ay` | Send an `@path#L…` reference to the Rex agent |
| `<leader>aY` | Send that reference together with the code |
| `<leader>ap` | Ask the agent about the current line or Visual selection |
| `<leader>ad` | Send diagnostics |
| `<leader>as` | Send the current symbol |
| `<leader>ah` | Send the current Git hunk |
| `<leader>aq` | Send the quickfix list |
| `<leader>al` | Send the location list |
| `<leader>at` | Pick the target agent (remembered until changed) |
| `<leader>aa` | Go to the agent pane |
| `<leader>jm` | Search YouTube Music with Jam |

`lua/rex/` treats Neovim splits and Rex panes as one grid. Rex's `Leader h/j/k/l` (and `Cmd+Alt+arrows`) send `<F13>`–`<F16>` into this Neovim, which move to the split in that direction and hand focus back to Rex at the edge.

Use `<leader>?` to inspect buffer-local mappings and `:LazyExtras` to review enabled LazyVim extras.

## Structure

```text
init.lua             Entry point
lua/config/          Core options, keymaps, autocmds, and lazy.nvim setup
lua/plugins/         Plugin specs and LazyVim overrides
lua/rex/             Rex integration: status, split/pane navigation, agent context
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
