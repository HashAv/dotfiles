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

# Pour que soit reconnu ~/.XCompose
# export GTK_IM_MODULE=xim

# Set custom prompt ; root = red ; others = green (case statement copied from begining of file)
if [ $(id -un) == "root" ]; then
  # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  export PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

dit(){ mplayer -user-agent "Mozilla/5.0" "http://translate.google.com/translate_tts?tl=fr&q=$(echo $* | sed 's#\ #\+#g')" > /dev/null 2>&1 ;  }

export CHROMIUM_USER_FLAGS=--password-store=detect

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

# This enables screen to read .bashrc
alias s="screen -S $USER -T xterm -s /bin/bash"

alias ll='ls -l'
alias l='ls -lh --time-style=long-iso'
alias la='ls -Alh --time-style=long-iso'
alias man='man -L en'
alias emacs='LANG=en emacs -nw'
alias be='bundle exec'

# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# This file should be sourced
# 1. in ~/.bash_login for remote ssh sessions
# 2. in ~/.bashrc for virtual terminal sessions (gnome-terminal, etc.)
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[[ -s "$HOME/.curl-ca-bundle/cacert.pem" ]] && export CURL_CA_BUNDLE="$HOME/.curl-ca-bundle/cacert.pem" # For CentOS
[[ -s ~/.rails.bash ]] && source ~/.rails.bash # bash autocompletion
