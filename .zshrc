##
#
# Zplug

source ~/.zplug/init.zsh

# Set history timestamp format.
HIST_STAMPS="yyyy-mm-dd"

fpath=(~/.zsh/completions $fpath)
autoload -U compinit && compinit

##
#
# Exports

export VISUAL=vim
export EDITOR=vim
export GIT_EDITOR=vim
export ZSH_CACHE_DIR=$HOME/.zsh/cache

export PATH=$HOME/bin:/usr/local/bin:$PATH

if [[ "$OSTYPE" == "darwin"* ]]; then

  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  # macports
  if [[ -d /opt/local/bin && -d /opt/local/sbin ]]; then
    export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
  fi

  if [[ -d /opt/local/Library/Frameworks/Python.framework/Versions/Current/bin ]]; then
    export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin:$PATH
  fi

  # macports manpages
  if [[ -d /opt/local/share/man ]]; then
    export MANPATH=/opt/local/share/man:$MANPATH
  fi

  # apache macport
  if [[ -d /opt/local/apache2/bin ]]; then
    export PATH=/opt/local/apache2/bin:$PATH
  fi

  # mysql macport
  if [[ -d /opt/local/lib/mysql55/bin ]]; then
    export PATH=/opt/local/lib/mysql55/bin:$PATH
  fi

  # percona
  if [[ -d /opt/local/lib/percona/bin ]]; then
    export PATH=/opt/local/lib/percona/bin:$PATH
  fi

  # goroot
  if [[ -d /opt/local/go ]]; then
    export GOROOT=/opt/local/go
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

# Composer
if [[ -d $HOME/.composer ]]; then
  export PATH=$HOME/.composer/vendor/bin:$PATH
fi

##
#
# Sourcing

if [[ "$OSTYPE" == "darwin"* ]]; then
  if [[ -f $HOME/.zkbd/xterm-mac ]]; then
    source $HOME/.zkbd/xterm-mac
  fi

  if [[ -f $HOME/.osx_aliases ]]; then
    source $HOME/.osx_aliases
  fi
fi

if [[ -f $HOME/.shell_aliases ]]; then
  source ~/.shell_aliases
fi

# Drush completion
if [[ -f $HOME/drush.complete.sh ]]; then
  autoload bashcompinit
  bashcompinit
  source $HOME/drush.complete.sh
fi

# Private stuff
if [[ -f $HOME/.zshrc_private ]]; then
  source $HOME/.zshrc_private
fi

# NVM
if [[ -f $HOME/.nvm/nvm.sh ]]; then
  source $HOME/.nvm/nvm.sh
fi

if [[ $+commands[hub] ]]; then
  eval "$(hub alias -s)"
fi

if [[ $+commands[python] ]]; then
  export PYTHONPATH=$(python -c "import os; print(os.path.dirname(os.__file__) + '/site-packages')")
fi

# Zplugins

zplug "zplug/zplug"

zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"

zplug "themes/ys", from:oh-my-zsh

zplug "plugins/colored-man", from:oh-my-zsh
zplug "plugins/fasd", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/pip", from:oh-my-zsh
zplug "plugins/vagrant", from:oh-my-zsh
zplug "plugins/colored-man", from:oh-my-zsh
zplug "plugins/composer", from:oh-my-zsh
zplug "plugins/npm", from:oh-my-zsh
zplug "plugins/rvm", from:oh-my-zsh
zplug "plugins/bower", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/history-substring-search", from:oh-my-zsh

zplug "zsh-users/zsh-syntax-highlighting", nice:19
zplug "zsh-users/zsh-completions"

zplug "plugins/macports", from:oh-my-zsh, if:"[ $OSTYPE == *darwin* ]"
zplug "plugins/osx", from:oh-my-zsh, if:"[ $OSTYPE == *darwin* ]"

zplug load --verbose

# Source fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Nice docker utilities
[ -f ~/.docker_utilities ] && source ~/.docker_utilities

# History substring search keybindings
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
