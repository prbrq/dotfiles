# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Contents

| File | Description |
|------|-------------|
| `.zshrc` | Zsh config — oh-my-zsh, mise, zoxide, bun |
| `.tmux.conf` | Tmux config — custom prefix, vim keys, status bar |
| `.config/Code/User/settings.json` | VS Code settings |
| `.config/Code/User/keybindings.json` | VS Code keybindings |

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
- [oh-my-zsh](https://ohmyz.sh/)
- [mise](https://mise.jdx.dev/)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [tmux](https://github.com/tmux/tmux)
- [bun](https://bun.sh/)
- [VS Code](https://code.visualstudio.com/)

## Installation

```bash
cd ~
git clone https://github.com/prbrq/dotfiles.git
cd dotfiles
stow --no-folding .
```

Stow will create symlinks from this repo into your home directory.

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
