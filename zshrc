source /etc/profile

if [[ -f $HOME/.profile ]]; then
  source $HOME/.profile
fi

if [[ -f $HOME/.shell_aliases ]]; then
  source ~/.shell_aliases
fi

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
HOSTNAME=`hostname -s`
PAGER='less'
EDITOR='/usr/bin/vim'
KERNEL=`uname`

setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -v

setopt inc_append_history

# Share command history between sessions.
setopt share_history

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/gergely/.zshrc'

autoload -U compinit && compinit
# End of lines added by compinstall

# do NOT nice bg commands
unsetopt BG_NICE

# command CORRECTION
setopt CORRECT

setopt MENUCOMPLETE
setopt ALL_EXPORT

setopt notify globdots correct pushdtohome cdablevars autolist
setopt correctall autocd recexact longlistjobs
setopt autoresume histignoredups pushdsilent
setopt autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash
setopt printexitvalue
setopt listtypes
setopt autolist
unsetopt menucomplete
unsetopt beep notify

# Autoload zsh modules when they are referenced
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof

autoload -U colors && colors
autoload zsh/terminfo

if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
fi

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
 eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
 eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
 (( count = $count + 1 ))
done

autoload zkbd

# exports
if [[ $KERNEL = "Darwin" ]]; then

  export LC_ALL=C
  export LANG=C
  
  if [[ -f $HOME/.zkbd/xterm-mac ]]; then
    source $HOME/.zkbd/xterm-mac
  fi

  if [[ -f $HOME/.osx_aliases ]]; then
    source $HOME/.osx_aliases
  fi

  # macports
  export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
  export MANPATH=/opt/local/share/man:$MANPATH

  # apache macport
  export PATH=/opt/local/apache2/bin:$PATH

  # mysql macport
  export PATH=/opt/local/lib/mysql55/bin:$PATH
fi

# key bindings
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
bindkey "^[[1;9D" backward-word
bindkey "^[[1;9C" forward-word

[[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
[[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
[[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
[[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
[[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

# completion stuff
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' menu yes select
xdvi() { command xdvi ${*:-*.dvi(om[1])} }
zstyle ':completion:*:*:xdvi:*' menu yes select
zstyle ':completion:*:*:xdvi:*' file-sort time
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*' ignored-patterns '*.sw*'
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete

# case-insensitive (all),partial-word and then substring completion
# http://www.rlazo.org/2010/11/18/zsh-case-insensitive-completion/
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
      'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# formatting and messages
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' file-sort 'time'

# awesome zsh modules
autoload zmv
zmodload zsh/net/socket

# some handy options
setopt no_hup hist_verify


#
# Drupal and drush
#

# Download Drupal in a project folder via drush.
dldrupal() {
  drush dl --drupal-project-rename="$*";
}

# Download a Drupal project, use git submodules for checking out
# new projects.
draddsub() {
  drush -d dl "$*" --package-handler=git_drupalorg --gitsubmodule;
}

# Run PHP_CodeSniffer on folder/file.
drupalcs() {
  phpcs --standard=Drupal --extensions=php,module,inc,install,test,profile,theme "$*";
}

# Disable and uninstall Drupal modules via drush.
drushdisun() {
  drush -y dis "$*"; drush -y pm-uninstall "$*"; drush cron;
}

# Enable Drupal modules via drush.
drushen() {
  drush -y en "$*"; drush cc all;
}

# Install Drupal site via drush.
drushsi() {
  if [[ $# -eq 1 ]]; then
    drush -y si --account-name="$1" --account-pass="$1";
  elif [[ $# -eq 2 ]]; then
    drush -y si "$1" --account-name="$2" --account-pass="$2";
  fi
}


#
# Helpers
#

# json pretty print
function pjson {
  if [ $# -gt 0 ];
      then
      for arg in $@
      do
          if [ -f $arg ];
              then
              less $arg | python -m json.tool
          else
              echo "$arg" | python -m json.tool
          fi
      done
  fi
}


#
# Git
#

# Get current branch name.
function _git_current_branch() {
  git symbolic-ref HEAD --short;
}

# Get tracked remote of current branch (if any).
# TODO: Handle if there is no tracking branch.
function _git_current_branch_tracked_remote() {
  git rev-parse --symbolic-full-name --abbrev-ref `_git_current_branch`@{u};
}

# Shorthand for git pull to local branch from remote branch with
# same name.
# TODO: get remote from tracked branch of current
function gpl() {
  git pull origin `_git_current_branch`;
}

# Shorthand for git push from local branch to remote branch with
# same name.
# TODO: get remote from tracked branch of current
funciton gps() {
  git push origin `_git_current_branch`;
}

# settings for git info in rprompt
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}


#
# Prompt
#

PS1='[%n@%m:%/]%# '

# Left prompt
#
# 2 lines:
#   1: Username, hostname, pwd.
#   2: Hour, minute, second.
#
# Example:
#   [username@hostname:pwd]
#   [hour:minute:second] %
#
PROMPT='[\
%{$fg[red]%}%n\
%{$reset_color%}@\
%{$fg[green]%}%m\
%{$reset_color%}:\
%{$fg[blue]%}%/\
%{$reset_color%}]\
%{$fg[red]%}\

%{$reset_color%}[\
%{$fg[red]%}%D{%H}\
%{$reset_color%}:\
%{$fg[green]%}%D{%M}\
%{$reset_color%}:\
%{$fg[blue]%}%D{%S}\
%{$reset_color%}] %# '

# Right prompt
#
# git info, see vcs_info_wrapper()
#
RPROMPT=$'$(vcs_info_wrapper)'


#
# Todotxt
#
export TODOTXT_DEFAULT_ACTION=ls
export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'

#
# Private stuff
#
if [[ -f $HOME/.zshrc_private ]]; then
  source $HOME/.zshrc_private
fi
