export ZSH="$HOME/.oh-my-zsh"

export PATH="$PATH:$HOME/.applinks"

export PATH="$PATH:$HOME/.dotnet/tools"

plugins=(git ssh zsh-syntax-highlighting zsh-autosuggestions dotnet)

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init bash)"

eval "$(starship init zsh)"
