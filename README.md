# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

| File | Description |
|------|-------------|
| `.zshrc` | Zsh config — zinit, mise, zoxide, bun |
| `.tmux.conf` | Tmux config — custom prefix, vim keys, status bar |
| `.config/zed/settings.json` | Zed settings — Vim mode, C# formatting, Codebook |
| `.config/zed/keymap.json` | Zed keybindings |
| `.config/ghostty/config` | Ghostty terminal settings |
| `.config/nvim/init.lua` | Neovim settings |
| `.config/codebook/codebook.toml` | Codebook spell checker settings |

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
- [zinit](https://github.com/zdharma-continuum/zinit) — auto-installed on first shell load
- [mise](https://mise.jdx.dev/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [tmux](https://github.com/tmux/tmux)
- [bun](https://bun.sh/)
- [Zed](https://zed.dev/)
- [Ghostty](https://ghostty.org/)
- [Codebook](https://github.com/blopker/codebook) — spell checker for Zed

## Installation

```bash
cd ~
git clone https://github.com/prbrq/dotfiles.git
cd dotfiles
stow --no-folding .
```

Stow will create symlinks from this repo into your home directory.

Zinit and all zsh plugins are installed automatically on first shell load — no manual steps required.

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
| `y` | Copy selection to clipboard (`pbcopy`) |
| `Escape` | Cancel |

### Misc

| Key | Action |
|-----|--------|
| `prefix + r` | Reload config |
