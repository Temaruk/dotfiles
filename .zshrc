# Set history timestamp format.
HIST_STAMPS="yyyy-mm-dd"

fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

##
# Exports

export VISUAL=vim
export EDITOR=vim
export GIT_EDITOR=vim
export ZSH_CACHE_DIR=$HOME/.zsh/cache

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH

if [[ "$OSTYPE" == "darwin"* ]]; then

  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  # goroot
  if [[ -d /usr/local/opt/go ]]; then
    export GOROOT=/usr/local/opt/go/libexec/bin
    export PATH=$PATH:$GOROOT
    launchctl setenv GOROOT $GOROOT
  fi

  # gopath
  if [[ -d $HOME/Work/go ]]; then
    export GOPATH=$HOME/Work/go
    export PATH=$PATH:$GOPATH/bin
    launchctl setenv GOPATH $GOPATH
  fi
fi

##
# Sourcing

if [[ "$OSTYPE" == "darwin"* ]]; then
  [ -f $HOME/.zkbd/xterm-mac ] && source $HOME/.zkbd/xterm-mac
  [ -f $HOME/.osx_aliases ] && source $HOME/.osx_aliases
fi

[ -f $HOME/.shell_aliases ] && source $HOME/.shell_aliases

# Private stuff
[ -f $HOME/.zshrc_private ] && source $HOME/.zshrc_private

# NVM
if [[ -f /usr/local/opt/nvm/nvm.sh ]]; then
  export NVM_DIR="$HOME/.nvm"
  source /usr/local/opt/nvm/nvm.sh
fi

# hub integration
if [[ $+commands[hub] ]]; then
  eval "$(hub alias -s)"
fi

if [[ $+commands[python] ]]; then
  export PYTHONPATH=$(python -c "import os; print(os.path.dirname(os.__file__) + '/site-packages')")
fi

# Zplugins

if [[ -d /usr/local/opt/zplug ]]; then
  export ZPLUG_HOME=/usr/local/opt/zplug
  source $ZPLUG_HOME/init.zsh

  zplug "zplug/zplug"

  zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"

  zplug "themes/ys", from:oh-my-zsh, as:theme

  zplug "plugins/colored-man", from:oh-my-zsh
  zplug "plugins/fasd", from:oh-my-zsh
  zplug "plugins/history", from:oh-my-zsh
  zplug "plugins/git", from:oh-my-zsh
  zplug "plugins/pip", from:oh-my-zsh
  zplug "plugins/vagrant", from:oh-my-zsh
  zplug "plugins/colored-man", from:oh-my-zsh
  zplug "plugins/npm", from:oh-my-zsh
  zplug "plugins/rvm", from:oh-my-zsh
  zplug "plugins/bower", from:oh-my-zsh
  zplug "plugins/docker", from:oh-my-zsh
  zplug "plugins/docker-compose", from:oh-my-zsh
  zplug "plugins/history-substring-search", from:oh-my-zsh

  zplug "zsh-users/zsh-syntax-highlighting", defer:2
  zplug "zsh-users/zsh-completions"

  zplug "plugins/osx", from:oh-my-zsh, if:"[ $OSTYPE == *darwin* ]"

  zplug load
fi

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Nice docker utilities
[ -f ~/.docker_utilities ] && source ~/.docker_utilities

# History substring search keybindings
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

[ -e ${HOME}/.iterm2_shell_integration.zsh ] && source ${HOME}/.iterm2_shell_integration.zsh

