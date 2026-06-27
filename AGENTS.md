# AGENTS.md

Guidance for AI coding agents working in this repository.

## What this is

Personal dotfiles for a developer who works on **both macOS and Linux**. Files are
symlinked into `$HOME` via [GNU Stow](https://www.gnu.org/software/stow/):

```bash
stow --no-folding --adopt .
```

The repo is the canonical home of these configs; do **not** edit the symlinked copies
in `$HOME` directly. Always edit the files here.

## Layout

| Path | Maps to | Purpose |
|------|---------|---------|
| `.zshrc` | `~/.zshrc` | Shell bootstrap — PATH, zinit, mise, zoxide, fzf, bun |
| `.zsh_aliases` | `~/.zsh_aliases` | `ls`/`eza`, navigation + safety aliases |
| `.tmux.conf` | `~/.tmux.conf` | Tmux: prefix `Ctrl+a`, vim keys, status bar |
| `.config/zed/*` | `~/.config/zed/*` | Zed editor — vim mode, C# formatting |
| `.config/nvim/init.lua` | `~/.config/nvim/init.lua` | Minimal Neovim (clipboard) |
| `.config/ghostty/config` | `~/.config/ghostty/config` | Ghostty terminal |
| `.config/codebook/codebook.toml` | `~/.config/codebook/codebook.toml` | Zed spell-check dict |
| `.config/Code/User/*` | `~/.config/Code/User/*` | VS Code settings |
| `.pi/agent/settings.json` | pi agent config — **managed by pi, do not hand-edit** |

`.pi/agent/settings.json` is owned by the `pi` coding agent; leave it alone unless
the user explicitly asks for a change.

## Cross-platform is a hard requirement

These configs run on macOS (Darwin) **and** Linux (both X11 and Wayland). When
editing, never assume one OS. Specifically:

- **No hardcoded absolute home paths.** Use `$HOME` / `~` instead of `/Users/arkady`.
  (There was previously a hardcoded `/Users/arkady/.lmstudio/bin` — that kind of
  thing is exactly what to avoid.)
- **No OS-sniffing where a feature-detection shim is cleaner.** See the tmux
  `copy_to_clipboard` function in `.tmux.conf`: it tries `pbcopy` → `wl-copy` →
  `xclip` in order instead of branching on `uname`.
- **`ls` flags differ between GNU and BSD.** `.zsh_aliases` handles this by
  preferring `eza` if installed, falling back to a color-flag-detecting `ls`.
  Don't reintroduce bare `ls --color=auto` — it errors on macOS BSD `ls`.
- **Clipboard tools are per-platform:** `pbcopy` (macOS), `wl-copy` (Wayland),
  `xclip` (X11). Detect, don't assume.

## Conventions

- Keep configs well-commented and sectioned with banner headers (see `.tmux.conf`
  style). Existing comment style: `# ---- Title ----`.
- Tmux prefix is `Ctrl+a`, windows/panes are 1-indexed, navigation is vim-style
  (`hjkl`). Respect these defaults when touching tmux bindings.
- Zsh uses **zinit** (not oh-my-zsh directly) — load plugins via `zinit` /
  `zinit snippet OMZP::...` / `zinit light`. Don't switch plugin managers.
- Aliases live in `.zsh_aliases`; `.zshrc` is kept minimal (bootstrap only).
- Default provider/model for pi lives in `.pi/agent/settings.json`.

## Verifying changes

There is no test suite. Validate manually:

- **Zsh:** `zsh -c 'source ~/.zshrc'` (expect no errors); for a specific file,
  `zsh -n .zsh_aliases` checks syntax without executing.
- **Tmux:** `tmux -f .tmux.conf new-session -d` then inspect, or run
  `tmux source-file .tmux.conf` inside an existing session.
- **eza/ls aliases:** open a fresh shell and run `ls`, `ll`, `la`, `lt`.
- **JSON files** (Zed, Code): `python3 -m json.tool < file` or `jq . file` to
  confirm validity.
- After editing, if the file is stowed, the symlink in `$HOME` picks up changes
  automatically — no re-stow needed.

## Don't

- Don't add tool-specific install scripts; prerequisites are listed in `README.md`.
- Don't introduce new hardcoded paths or OS-only branches.
- Don't edit `.pi/agent/settings.json` unless explicitly asked.
- Don't bump dependency pins or rewrite working configs to chase "modern" style
  unless asked — these are stable personal setups.