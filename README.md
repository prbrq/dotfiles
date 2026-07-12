# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

| File | Description |
|------|-------------|
| `.zshrc` | Zsh config — zinit, mise, zoxide, bun |
| `.zsh_aliases` | `ls`/`eza`, navigation + safety aliases |
| `.tmux.conf` | Tmux config — custom prefix, vim keys, status bar |
| `.config/zed/settings.json` | Zed settings — Vim mode, C# formatting, Codebook |
| `.config/zed/keymap.json` | Zed keybindings |
| `.config/ghostty/config` | Ghostty terminal settings |
| `.config/nvim/init.lua` | Neovim config — LazyVim + Roslyn C# stack; see `.config/nvim/README.md` |
| `.config/codebook/codebook.toml` | Codebook spell checker settings |
| `.config/Code/User/*` | VS Code settings |
| `.pi/agent/settings.json` | pi agent config — **managed by pi, do not hand-edit** |

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
- [zinit](https://github.com/zdharma-continuum/zinit) — auto-installed on first shell load
- [mise](https://mise.jdx.dev/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [tmux](https://github.com/tmux/tmux)
- [bun](https://bun.sh/)
- [eza](https://github.com/eza-community/eza) — modern `ls` (recommended; aliases fall back to `ls` if absent)
- [Zed](https://zed.dev/)
- [Ghostty](https://ghostty.org/)
- [Codebook](https://github.com/blopker/codebook) — spell checker for Zed
- [Neovim](https://neovim.io/) >= 0.12 — LazyVim/Roslyn setup
- [.NET SDK](https://dotnet.microsoft.com/download) — required by Roslyn/C# tooling
- [roslyn-language-server](https://github.com/dotnet/roslyn) — installed as a global dotnet tool

## Installation

```bash
cd ~
git clone https://github.com/prbrq/dotfiles.git
cd dotfiles
stow --no-folding --adopt .
```

Stow will create symlinks from this repo into your home directory.

Zinit and all zsh plugins are installed automatically on first shell load — no manual steps required.

For Neovim C# support, see `.config/nvim/README.md`.

The repo is the canonical home of these configs; do **not** edit the symlinked copies
in `$HOME` directly. Always edit the files here. After editing, stowed symlinks pick
up changes automatically — no re-stow needed.

## Tmux Cheatsheet

Prefix: `Ctrl+a`

### Sessions & Windows

| Key | Action |
|-----|--------|
| `prefix + c` | New window (in current dir) |
| `prefix + n` | Next window |
| `prefix + p` | Previous window |
| `prefix + <` | Swap window left |
| `prefix + >` | Swap window right |
| `prefix + X` | Kill window |

### Panes

| Key | Action |
|-----|--------|
| `prefix + \|` | Split horizontally (in current dir) |
| `prefix + -` | Split vertically (in current dir) |
| `prefix + h/j/k/l` | Navigate panes (vim-style) |
| `prefix + H/J/K/L` | Resize pane (repeatable) |
| `prefix + x` | Kill pane |

### Copy Mode

| Key | Action |
|-----|--------|
| `prefix + v` | Enter copy mode |
| `v` | Begin selection |
| `y` | Copy selection to system clipboard (macOS: `pbcopy`, Wayland: `wl-copy`, X11: `xclip`) |
| `Escape` | Cancel |

### Misc

| Key | Action |
|-----|--------|
| `prefix + r` | Reload config |

## Notes for AI coding agents

Guidance for AI agents (and humans) editing this repo.

### Cross-platform is a hard requirement

These configs run on macOS (Darwin) **and** Linux (both X11 and Wayland). Never
assume one OS:

- **No hardcoded absolute home paths.** Use `$HOME` / `~` instead of `/Users/arkady`.
- **No OS-sniffing where a feature-detection shim is cleaner.** See the tmux
  `copy_to_clipboard` function in `.tmux.conf`: it tries `pbcopy` → `wl-copy` →
  `xclip` in order instead of branching on `uname`.
- **`ls` flags differ between GNU and BSD.** `.zsh_aliases` prefers `eza` if
  installed, falling back to a color-flag-detecting `ls`. Don't reintroduce bare
  `ls --color=auto` — it errors on macOS BSD `ls`.
- **Clipboard tools are per-platform:** `pbcopy` (macOS), `wl-copy` (Wayland),
  `xclip` (X11). Detect, don't assume.

### Conventions

- Keep configs well-commented and sectioned with banner headers (see `.tmux.conf`
  style). Existing comment style: `# ---- Title ----`.
- Tmux prefix is `Ctrl+a`, windows/panes are 1-indexed, navigation is vim-style
  (`hjkl`). Respect these defaults when touching tmux bindings.
- Zsh uses **zinit** (not oh-my-zsh directly) — load plugins via `zinit` /
  `zinit snippet OMZP::...` / `zinit light`. Don't switch plugin managers.
- Neovim uses **LazyVim + roslyn.nvim** for C#. Don't enable LazyVim's
  `lang.dotnet` extra unless explicitly asked — it configures OmniSharp.
- Aliases live in `.zsh_aliases`; `.zshrc` is kept minimal (bootstrap only).
- Default provider/model for pi lives in `.pi/agent/settings.json`.

### Verifying changes

There is no test suite. Validate manually:

- **Zsh:** `zsh -c 'source ~/.zshrc'` (expect no errors); for a specific file,
  `zsh -n .zsh_aliases` checks syntax without executing.
- **Tmux:** `tmux -f .tmux.conf new-session -d` then inspect, or run
  `tmux source-file .tmux.conf` inside an existing session.
- **eza/ls aliases:** open a fresh shell and run `ls`, `ll`, `la`, `lt`.
- **Neovim:** `nvim --headless "+Lazy! sync" "+sleep 10" +qa` to install/update plugins;
  open a `.cs` file in a project and run `:LspInfo` to confirm Roslyn attached.
- **JSON files** (Zed, Code): `python3 -m json.tool < file` or `jq . file` to
  confirm validity.

### Don't

- Don't add tool-specific install scripts; prerequisites are listed above.
- Don't introduce new hardcoded paths or OS-only branches.
- Don't edit `.pi/agent/settings.json` unless explicitly asked.
- Don't bump dependency pins or rewrite working configs to chase "modern" style
  unless asked — these are stable personal setups.