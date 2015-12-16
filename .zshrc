##
#
# Antigen config

# Source antigen,
ZSHA_BASE=$HOME/.zsh-antigen
source $ZSHA_BASE/antigen.zsh

# Set history timestamp format.
HIST_STAMPS="yyyy-mm-dd"

##
#
# Exports

export VISUAL=vim
export EDITOR=vim
export GIT_EDITOR=vim

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

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundles <<EOBUNDLES
  fasd
  history
  git
  pip
  vagrant
  colored-man
  composer
  npm
  rvm
  bower
  docker
  docker-compose
EOBUNDLES

# Other bundles.
antigen-bundle zsh-users/zsh-history-substring-search

antigen bundle zsh-users/zsh-completions src

# OS specific bundles.
if [[ "$OSTYPE" == "darwin"* ]]; then
  antigen bundles <<EOBUNDLES
    osx
    macports
    apache2-macports
EOBUNDLES
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  antigen bundle command-not-found
fi

# Custom local bundles.
antigen-bundle $HOME/dotfiles/oh-my-zsh-custom/plugins/hub

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen theme ys

# Tell antigen that you're done.
antigen apply

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.docker_utilities ] && source ~/.docker_utilities
