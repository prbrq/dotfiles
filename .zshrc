export ZSH="$HOME/.oh-my-zsh"

plugins=(git ssh dotnet colored-man-pages)

source $ZSH/oh-my-zsh.sh

eval "$(~/.local/bin/mise activate zsh)"

eval "$(zoxide init bash)"

eval "$(starship init zsh)"
