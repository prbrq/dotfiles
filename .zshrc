export ZSH="$HOME/.oh-my-zsh"

export PATH="$PATH:$HOME/.applinks"

export PATH="$HOME/.local/bin:$PATH"

export PATH="$PATH:$HOME/.dotnet/tools"

plugins=(git ssh dotnet colored-man-pages)

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init bash)"

eval "$(starship init zsh)"
eval "$(~/.local/bin/mise activate zsh)"
