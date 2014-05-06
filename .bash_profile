source ~/.profile # Get the paths
source ~/.shell_aliases  # get aliases
source ~/.git-completion.bash

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PS1="\u@\h[\w]\$ "
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
