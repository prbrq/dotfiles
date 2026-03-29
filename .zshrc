export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="refined"

export PATH="$PATH:$HOME/.applinks"

export PATH="$HOME/.local/bin:$PATH"

export PATH="$PATH:$HOME/.dotnet/tools"

plugins=(git ssh dotnet colored-man-pages zsh-syntax-highlighting zsh-autosuggestions zsh-completions)

source $ZSH/oh-my-zsh.sh

eval "$(~/.local/bin/mise activate zsh)"

eval "$(zoxide init --cmd cd zsh)"

# bun completions
[ -s "/home/arkady/.bun/_bun" ] && source "/home/arkady/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/arkady/.lmstudio/bin"
# End of LM Studio CLI section

eval "$(fzf --zsh)"
