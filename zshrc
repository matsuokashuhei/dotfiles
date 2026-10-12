eval "$(starship init zsh)"
eval "$(mise activate zsh)"

# fpath
fpath=($(brew --prefix)/share/zsh-completions $fpath)
fpath=(~/.docker/completions $fpath)
autoload -Uz compinit
compinit

# fzf
source <(fzf --zsh)
