# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Don't record those in .bash_history
# export HISTIGNORE="history:pwd:ls:cd:vh:cal:"

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=9999  # memory
HISTFILESIZE=9999

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# globing for ls (not cd)
# shopt -s nocaseglob

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias be='bundle exec'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias batfull='upower -i /org/freedesktop/UPower/devices/battery_BAT0 && echo "---" && acpi -V | grep --color=never ^Battery'
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0 | egrep "state:|percentage:" | ruby -ne "puts \$_.split.map { |s| s.ljust(15)}.join" && echo "---" && acpi -V | grep --color=never ^Battery'

alias rr='if [ -f /var/run/reboot-required  ]; then echo "Reboot required"; else echo "No reboot needed"; fi'
alias rrr='find /etc/update-motd.d/{00-header,98-reboot}* | xargs -L1 bash'
#security upgrade required
alias sur='apt-get upgrade --dry-run | grep -i security || echo NO_SECURITY_UPDATES_REQUIRED'
alias weather='curl http://wttr.in | less -RS'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

source ~/.fzf.bash

function source_env() {
  for FPATH in "$@";do

    echo "Sourcing: $FPATH"
    if ! [ -f $FPATH ];then
      echo "source_env: path is not valid!"
      return 1
    fi

    local DPATH=$(dirname $FPATH)

    local FPERM=$(stat -c '%a' $FPATH)
    local DPERM=$(stat -c '%a' $DPATH)

    if [[ $(stat -c '%a' $DPATH) != '700' ]];then
      echo "source_env: invalid perm for: $DPATH ($DPERM)"
    fi

    if [[ $(stat -c '%a' $FPATH) != '600' ]];then
      echo "source_env: invalid perm for: $FPATH ($FPERM)"
    fi

    set -a
    source $FPATH
    set +a
  done
}
alias se="source_env"

function cd_into() {
  SEARCHED_DIR=$(find . -name $1 -type d | sed 1q)

  if [[ -d $SEARCHED_DIR ]]; then
    cd "$SEARCHED_DIR"
  else
    echo "No match found for $1 (from `pwd`)"
  fi
}

function ncal2less() {
  # When piping, ncal does not generate highling sequences, but rather the following sequence:
  # UNDERSCORE BACKSLASH NUM UNDERSCORE BACKSLASH NUM?
  # this function replaces that with a colored (yellow) highlighting instead
  ncal "$@" | sed 's/_\x08\([0-9]\)_\x08\([0-9 ]\)/\x1b[1;33m\1\2\x1b[1;m/' | less -RS
}

function clear_gems() {
  gem list | grep -Ev 'test\-unit|bundler|rdoc|rake|psych|io\-console|bigdecimal|json|minitest|pry|tmuxinator' | cut -d' ' -f1 | xargs gem uninstall -Iax
}

function gotestcolor() {
	go test $@ | colout '(PASS)|(FAIL)' green,red
}

function so() {
  echo "Updating mlocate..."
  sudo /etc/cron.daily/mlocate
  export FZF_ALT_C_COMMAND="locate -r 'BonsDeLivraison/.\+pdf' -0 | xargs -0 dirname | grep -v '\.pdf$' | grep -F '/BL.' | sort -r -t/ -k10,10 | uniq"
  echo "Now use Alt-C to search for shipping order folders"
}

export GOPATH=~/code/go
export GOROOT=~/.local/software/go

export PATH=$PATH:~/.local/software/go/bin/:~/code/go/bin/

export LEDGER_FILE=~/Private2/Banking/main.ledger
export LEDGER_FILE_EXPORT=~/Private2/Banking/export/main.json
export EDITOR=vim
export PAGER="less -RS" # For psql

export REMINDERS_DB_PATH=~/Dropbox/PrivSync/.reminders.sqlite
export TASKS_PATH=~/Private2/bin/tasks/

echo "Ensure tasks_runner is running"
# run-parts ~/Private2/bin/tasks

alias utt_edit="vim -c 'normal G$' ~/.local/share/utt/utt.log"

export CDPATH="~/code/bitbucket.org/benjamin-thomas/:~/code/github.com/benjamin-thomas/:~/code/go/src/github.com/benjamin-thomas/"
