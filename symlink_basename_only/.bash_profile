# include .bashrc if it exists
echo "DEBUG bash_profile 1"
echo $PATH | ruby -ne 'puts $_.split(":")' | grep soft

if [ -f "$HOME/.bashrc" ]; then
. "$HOME/.bashrc"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.bin/bin" ] ; then
    PATH="$HOME/.bin/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ];then
    PATH="$PATH:$HOME/.cargo/bin"
fi

if [ -d "$HOME/.npm-global" ] ; then
    PATH="$HOME/.npm-global/bin:$PATH"
fi

if [ -d "$HOME/.luarocks" ] ; then
    PATH="$HOME/.luarocks/bin:$PATH"
fi

# https://gradle.org/install/
if [ -d "/opt/gradle" ];then
  PATH="$PATH:/opt/gradle/gradle-6.1.1/bin"
fi

[ -d $HOME/.local/software/node/bin ] && PATH="$PATH:$HOME/.local/software/node/bin"

GEM_BIN_PATH=$(gem env gempath | ruby -ne 'puts $_.strip.split(":").map { |dir| File.join(dir, "bin")}.join(":")')
GEM_HOME=~/.cache/gems

if [ ! -z $GEM_BIN_PATH ];then
  PATH=$PATH:$GEM_BIN_PATH
else
  echo "~/.bash_profile: Could not generate GEM_BIN_PATH"
fi

#export GOPATH=$HOME/code/go
#export GOROOT=$HOME/.local/software/go/
#export PATH=$PATH:$GOPATH/bin

if [ -f $HOME/.config/exercism/exercism_completion.bash ]; then
  . $HOME/.config/exercism/exercism_completion.bash
fi

WORKON_HOME=$HOME/.virtualenvs
[[ -f $HOME/.local/bin/virtualenvwrapper_lazy.sh ]] && source $HOME/.local/bin/virtualenvwrapper_lazy.sh

function ssh_auth_sock_refresh() {
  if [[ -S "$SSH_AUTH_SOCK" ]];then
    # using agent forwarding...
    echo "SSH_AUTH_SOCK already set and active, exiting now."
    return # return, not exit, otherwises closes session
  fi

  if pgrep -u $UID ssh-agent &>/dev/null; then
    if [[ $(pgrep -u $UID ssh-agent | wc -l) != 1 ]];then
      echo "bash_profile: Problem with ssh-agent, exiting now!"
      return
    fi
    echo "Reconnecting to ssh-agent"
    export SSH_AUTH_SOCK=$(find /tmp -maxdepth 2 -type s -name "agent*" -user $USER -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2)
    export SSH_AGENT_PID=$(pgrep -u $UID ssh-agent)
  else
    echo "Setting up ssh-agent"
    set -a
    eval $(ssh-agent) &>/dev/null
    ssh-add
    set +a
  fi
}

if [[ $LANG == "" || $LANG == "C" ]];then
  echo "System locale not setup properly"
  echo "Set globally: localectl set-locale LANG=en_US.utf8 && localectl status"
fi

export TERM=xterm-256color

# export LANG=fr_FR.utf8 LC_TIME=fr_FR.utf8 # override default for user programs

if [ $(which check_repos) ];then
  TOUCH_PATH="/run/user/$(id -u)/check_repos"

  if ! [ $(find "$TOUCH_PATH" -mmin $(( -1 * 60 * 4 )) 2>/dev/null) ];then # 4 hours
    touch "$TOUCH_PATH"
    check_repos -e 1>/dev/null
  fi
fi

if [ $(which check_hosts) ];then
  TOUCH_PATH="/run/user/$(id -u)/check_hosts"

  if ! [ $(find "$TOUCH_PATH" -mmin $(( -1 * 5 )) 2>/dev/null) ];then # 5 minutes
    touch "$TOUCH_PATH"
    check_hosts
  fi
fi

export PATH="$HOME/.cargo/bin:$PATH"


TOUCH_PATH="/run/user/$(id -u)/remove_bash_history_duplicates"
if ! [ $(find "$TOUCH_PATH" -mmin $(( -1 * 60 * 4 )) 2>/dev/null) ];then # 4 hours
  touch "$TOUCH_PATH"
  echo "Removing non consecutive bash history duplicates"
  ruby -i -e 'puts readlines.reverse.uniq.reverse' ~/.bash_history
fi

[ -d ~/.local/bin/completion ] && source ~/.local/bin/completion/*

eval "$(rbenv init -)"
