#
# TODO:
# - Cleanup, extract .osx_variables
# - Make use of antigen (https://github.com/zsh-users/antigen)
#

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colored-man macports git composer drupal drush vagrant pip zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

KERNEL=`uname`

if [[ -f $HOME/.shell_aliases ]]; then
  source ~/.shell_aliases
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

if [[ $KERNEL = "Darwin" ]]; then

  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  if [[ -f $HOME/.zkbd/xterm-mac ]]; then
    source $HOME/.zkbd/xterm-mac
  fi

  if [[ -f $HOME/.osx_aliases ]]; then
    source $HOME/.osx_aliases
  fi

  # Set preferred editor.
  if [[ `command -v atom` >/dev/null ]]; then
    export VISUAL=atom
    export EDITOR=atom
    export GIT_EDITOR='atom --wait'
  fi

  # macports
  if [[ -d /opt/local/bin && -d /opt/local/sbin ]]; then
    export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
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

  #percona
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

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#
# Private stuff
#
if [[ -f $HOME/.zshrc_private ]]; then
  source $HOME/.zshrc_private
fi

# Drush completion
if [[ -f $HOME/drush.complete.sh ]]; then
  autoload bashcompinit
  bashcompinit
  source $HOME/drush.complete.sh
fi
