# PATH
export PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local-bin" ] && export PATH="$HOME/.local-bin:$PATH"
export PATH="$PATH:$HOME/.applinks"
export PATH="$PATH:$HOME/.dotnet/tools"
export PATH="$PATH:/Users/arkady/.lmstudio/bin"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# OMZ theme
zinit snippet OMZT::refined

# OMZ plugins
zinit snippet OMZP::git
zinit snippet OMZP::ssh-agent
zinit snippet OMZP::dotnet
zinit snippet OMZP::colored-man-pages

# Community plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Tools
eval "$(~/.local/bin/mise activate zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# Aliases
[ -f "$HOME/.zsh_aliases" ] && source "$HOME/.zsh_aliases"

# bun completions
[ -s "/home/arkady/.bun/_bun" ] && source "/home/arkady/.bun/_bun"
