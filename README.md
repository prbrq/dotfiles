# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

| File | Description |
|------|-------------|
| `.zshrc` | Zsh config — zinit, mise, zoxide, bun |
| `.zsh_aliases` | `ls`/`eza`, navigation + safety aliases |
| `.config/herdr/config.toml` | Herdr config — agent multiplexer, `Ctrl+a` prefix, vim keys |
| `.config/nvim/init.lua` | Neovim config — minimal Markdown rendering |
| `.config/zed/settings.json` | Zed settings — Vim mode, C# formatting, Codebook |
| `.config/zed/keymap.json` | Zed keybindings |
| `.config/ghostty/config` | Ghostty terminal settings |
| `.config/codebook/codebook.toml` | Codebook spell checker settings |
| `.config/Code/User/*` | VS Code settings |
| `.pi/agent/settings.json` | pi agent config — **managed by pi, do not hand-edit** |

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
- [zinit](https://github.com/zdharma-continuum/zinit) — auto-installed on first shell load
- [mise](https://mise.jdx.dev/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [Herdr](https://herdr.dev/) — terminal-native agent multiplexer
- [Neovim 0.12+](https://neovim.io/) — minimal Markdown editor config
- [tree-sitter CLI](https://tree-sitter.github.io/tree-sitter/) — required for Neovim Markdown parser install
- [bun](https://bun.sh/)
- [eza](https://github.com/eza-community/eza) — modern `ls` (recommended; aliases fall back to `ls` if absent)
- [Zed](https://zed.dev/)
- [Ghostty](https://ghostty.org/)
- [Codebook](https://github.com/blopker/codebook) — spell checker for Zed

## Installation

```bash
cd ~
git clone https://github.com/prbrq/dotfiles.git
cd dotfiles
stow --no-folding --adopt .
```

Stow will create symlinks from this repo into your home directory.

Zinit and all zsh plugins are installed automatically on first shell load — no manual steps required.
Neovim plugins are managed by `lazy.nvim` and installed automatically on first `nvim` launch.
Herdr can be installed with Homebrew (`brew install herdr`) or the upstream installer (`curl -fsSL https://herdr.dev/install.sh | sh`).

The repo is the canonical home of these configs; do **not** edit the symlinked copies
in `$HOME` directly. Always edit the files here. After editing, stowed symlinks pick
up changes automatically — no re-stow needed.

## Herdr Cheatsheet

Prefix: `Ctrl+a`

### Tabs & Workspaces

| Key | Action |
|-----|--------|
| `prefix + c` | New tab in the current workspace |
| `prefix + n` | Next tab |
| `prefix + p` | Previous tab |
| `prefix + X` | Close tab |
| `prefix + w` | Workspace picker |
| `prefix + g` | Session navigator / goto picker |

### Panes

| Key | Action |
|-----|--------|
| `prefix + v` | Split right |
| `prefix + -` | Split down |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + H/J/K/L` | Swap panes |
| `prefix + r` | Enter resize mode |
| `prefix + x` | Close pane |

### Copy Mode

| Key | Action |
|-----|--------|
| `prefix + [` | Enter copy mode |
| `v` or `Space` | Begin selection |
| `y` or `Enter` | Copy selection |
| `q` or `Escape` | Exit copy mode |

### Misc

| Key | Action |
|-----|--------|
| `prefix + q` | Detach, leaving panes running |
| `prefix + Shift+r` | Reload Herdr config |
| `prefix + ?` | Show active keybindings |
| `herdr --remote <host>` | Attach to a remote Herdr session through SSH |

## Notes for AI coding agents

Guidance for AI agents (and humans) editing this repo.

### Cross-platform is a hard requirement

These configs run on macOS (Darwin) **and** Linux (both X11 and Wayland). Never
assume one OS:

- **No hardcoded absolute home paths.** Use `$HOME` / `~` instead of `/Users/arkady`.
- **Prefer built-in cross-platform behavior.** Herdr handles mouse copy/remote attach clipboard behavior; if you add shell glue, feature-detect tools instead of branching on `uname`.
- **`ls` flags differ between GNU and BSD.** `.zsh_aliases` prefers `eza` if
  installed, falling back to a color-flag-detecting `ls`. Don't reintroduce bare
  `ls --color=auto` — it errors on macOS BSD `ls`.
- **Clipboard tools are per-platform:** `pbcopy` (macOS), `wl-copy` (Wayland),
  `xclip` (X11). Detect, don't assume.

### Conventions

- Keep configs well-commented and sectioned with banner headers where useful.
- Herdr prefix is `Ctrl+a`, tabs/panes keep vim-style navigation (`hjkl`), and workspaces should map to projects/repos.
- Herdr config lives in `.config/herdr/config.toml`; use documented key names from Herdr's config reference.
- Zsh uses **zinit** (not oh-my-zsh directly) — load plugins via `zinit` /
  `zinit snippet OMZP::...` / `zinit light`. Don't switch plugin managers.
- Aliases live in `.zsh_aliases`; `.zshrc` is kept minimal (bootstrap only).
- Default provider/model for pi lives in `.pi/agent/settings.json`.

### Verifying changes

There is no test suite. Validate manually:

- **Zsh:** `zsh -c 'source ~/.zshrc'` (expect no errors); for a specific file,
  `zsh -n .zsh_aliases` checks syntax without executing.
- **Herdr:** `python3 -c 'import tomllib; tomllib.load(open(".config/herdr/config.toml", "rb"))'` validates TOML; inside a running Herdr session, use `herdr server reload-config`.
- **Neovim:** `nvim --headless "+Lazy! sync" +qa` installs/syncs plugins; `nvim --headless "+qa"` checks startup.
- **eza/ls aliases:** open a fresh shell and run `ls`, `ll`, `la`, `lt`.
- **Strict JSON files** (VS Code, pi): `python3 -m json.tool < file` or `jq . file` to confirm validity. Zed config is JSONC and may use trailing commas.

### Don't

- Don't add tool-specific install scripts; prerequisites are listed above.
- Don't introduce new hardcoded paths or OS-only branches.
- Don't edit `.pi/agent/settings.json` unless explicitly asked.
- Don't bump dependency pins or rewrite working configs to chase "modern" style
  unless asked — these are stable personal setups.