eval "$(starship init zsh)"
eval "$(mise activate zsh)"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/matsuokashuhei/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions
