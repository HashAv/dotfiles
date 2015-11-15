# include .bashrc if it exists
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

GEM_BIN_PATH=$(gem env gempath | ruby -ne 'puts $_.strip.split(":").map { |dir| File.join(dir, "bin")}.join(":")')

if [ ! -z $GEM_BIN_PATH ];then
  PATH=$PATH:$GEM_BIN_PATH
else
  echo "~/.bash_profile: Could not generate GEM_BIN_PATH"
fi

export GOPATH=$HOME/code/go
export GOROOT=$HOME/.local/software/go/
export PATH=$PATH:$GOPATH/bin

if [ -f $HOME/.config/exercism/exercism_completion.bash ]; then
  . $HOME/.config/exercism/exercism_completion.bash
fi

WORKON_HOME=$HOME/.virtualenvs
[[ -f $HOME/.local/bin/virtualenvwrapper_lazy.sh ]] && source $HOME/.local/bin/virtualenvwrapper_lazy.sh

if pgrep -u $UID ssh-agent &>/dev/null; then
  if [ -z $SSH_AUTH_SOCK ];then
    if [[ $(pgrep -u $UID ssh-agent | wc -l) != 1 ]];then
      echo "bash_profile: Problem with ssh-agent!"
    else
      echo "Reconnecting to ssh-agent"
      export SSH_AUTH_SOCK=$(find /tmp -maxdepth 2 -type s -name "agent*" -user $USER -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2)
      export SSH_AGENT_PID=$(pgrep -u $UID ssh-agent)
    fi
  fi
else
  echo "Setting up ssh-agent"
  set -a
  eval $(ssh-agent) &>/dev/null
  set +a
fi

if [[ $LANG == "" || $LANG == "C" ]];then
  echo "System locale not setup properly"
  echo "Use: localectl set-locale LANG=en_US.utf8 && localectl status"
fi
