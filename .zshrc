export ZSH="$HOME/.oh-my-zsh"

export PATH="$PATH:$HOME/.applinks"

export PATH="$HOME/.local/bin:$PATH"

export PATH="$PATH:$HOME/.dotnet/tools"

plugins=(git ssh dotnet colored-man-pages zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

eval "$(~/.local/bin/mise activate zsh)"

eval "$(zoxide init bash)"

ZSH_THEME="refined"

# bun completions
[ -s "/home/arkady/.bun/_bun" ] && source "/home/arkady/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
