# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
# HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# HISTSIZE: contains a number of lines which are remembered in the actual shell
export HISTSIZE=65536

# HISTFILESIZE: sets the maximum number of lines in your history file
HISTFILESIZE=65536

# Don't record those in .bash_history
# export HISTIGNORE="history:pwd:ls:cd:vh:cal:"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# globing for ls (not cd)
shopt -s nocaseglob

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

export EDITOR=vim
export SHELL=/bin/bash

# No line wraps (in Hirb/rails at least)
export PAGER="less -S"

# Set custom prompt ; root = red ; others = green (case statement copied from begining of file)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
PURPLE=$(tput setaf 5)
BOLD=$(tput bold)
RESET=$(tput sgr0)

export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose GIT_PS1_DESCRIBE_STYLE=branch

ARCHLINUX_GIT_COMPLETION=/usr/share/git/completion/git-completion.bash
ARCHLINUX_GIT_PROMPT=/usr/share/git/completion/git-prompt.sh
[ -f $ARCHLINUX_GIT_COMPLETION ] && source $ARCHLINUX_GIT_COMPLETION
[ -f $ARCHLINUX_GIT_PROMPT ] && source $ARCHLINUX_GIT_PROMPT

# Have vi behaviour
# set -o vi
bind -m vi-insert "\C-l":clear-screen                 # ^l clear screen
bind -m vi-insert "\C-n":menu-complete                # ^n cycle through the list of partial matches
bind -m vi-insert "\C-p":menu-complete-krd            # ^p cycle through the list of partial matches, backwards
bind -m vi-insert "\C-g":vi-movement-mode             # Other keys ^c, ^v, ^q, ^s don't work !
bind -m vi-insert 'Control-a: beginning-of-line'      # Ctrl-A: insert at line start like in emacs mode
bind -m vi-insert 'Control-e: end-of-line'            # Ctrl-E: append at line end like in emacs mode

# Needed for vim <C-S> mapping
stty -ixon

alias ll='ls -l'
alias l='ls -lh --time-style=long-iso'
alias la='ls -Alh --time-style=long-iso'
alias be='bundle exec'
which ack-grep &>/dev/null && alias ack="ack-grep"

[[ -s "$HOME/.curl-ca-bundle/cacert.pem" ]] && export CURL_CA_BUNDLE="$HOME/.curl-ca-bundle/cacert.pem" # For CentOS
[[ -s ~/.rails.bash ]] && source ~/.rails.bash # bash autocompletion


######################################################################
# Better bash prompt. Switches when inside a git repo automatically
######################################################################
function git_repo {
curr_repo=$(git rev-parse --show-toplevel 2>/dev/null | sed 's:.*/::')
if [[ $curr_repo != "" ]]; then
  echo "[${curr_repo}]"
fi
}

function ruby_version {
  VERSION=$(ruby -v | awk '{ print $2}')
  echo "‹${VERSION}›"
}

function prompt_func() {
   RED="\[\033[1;31m\]"
 GREEN="\[\033[1;32m\]"
YELLOW="\[\033[1;33m\]"
  BLUE="\[\033[1;34m\]"

 NO_COLOR="\[\e[0m\]"

  if [ $(id -un) == "root"  ]; then
    user_prompt="${RED}\u@\h${NO_COLOR}:${BLUE}\w"
    prompt_tail="${NO_COLOR}# "
  else
    user_prompt="${GREEN}\u@\h${NO_COLOR}:${BLUE}\w"
    prompt_tail="${NO_COLOR}$ "
  fi

  ruby_prompt="${RED}$(ruby_version)"
  git_prompt="${YELLOW}$(git_repo)${GREEN}$(__git_ps1)"

  if [[ $(git_repo) != "" ]]; then
    PS1="${user_prompt} ${ruby_prompt} ${git_prompt} \n${prompt_tail}"
  else
    PS1="${user_prompt}${prompt_tail}"
  fi
}

# pacman -S bash-completion
[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

PROMPT_COMMAND=prompt_func

function cd_into() {
  SEARCHED_DIR=$(find . -name $1 -type d | sed 1q)

  if [[ -d $SEARCHED_DIR ]]; then
    cd "$SEARCHED_DIR"
  else
    echo "No match found for $1 (from `pwd`)"
  fi
}

function clear_gems() {
  gem list | grep -Ev 'test\-unit|bundler|rdoc|rake|psych|io\-console|bigdecimal|json|minitest|pry' | cut -d' ' -f1 | xargs gem uninstall -Iax
}

alias chrome_dev="google-chrome --user-data-dir=$HOME/.config/google-chrome-dev/"
alias firefox_dev="firefox -P dev"

function git_tree_check() {
  CWD=`pwd`
  for file in $(find "$1" -name "*.git"); do
    cd $(dirname $file)
    if [ -z "$(git status --porcelain)" ]; then
      echo -en "\033[1;32mCLEAN\033[1;m"
      echo -n ": $(pwd) "
    else
      # Uncommitted changes
      echo -en "\033[1;31mNOTOK\033[1;m"
      echo -n ": $(pwd) "
      echo
      echo "Exiting!"
      NEEDS_FIX=true
      break
    fi

    if [ -z "$(git remote show)" ]; then
      echo -en "\033[1;31m[MISSING REMOTE]\033[1;m"
    else
      echo -en "\033[1;33m[$(git remote -v show | grep push | awk '{ print $1":" $2 }' | xargs)]"
    fi
    echo
  done
  [ -z $NEEDS_FIX ] && cd $CWD
}
