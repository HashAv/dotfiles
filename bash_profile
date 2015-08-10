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

export GOPATH=$HOME/code/go
export GOROOT=$HOME/.local/software/go/
export PATH=$PATH:$GOPATH/bin

if [ -f $HOME/.config/exercism/exercism_completion.bash ]; then
  . $HOME/.config/exercism/exercism_completion.bash
fi

WORKON_HOME=$HOME/.virtualenvs
[[ -f $HOME/.local/bin/virtualenvwrapper_lazy.sh ]] && source $HOME/.local/bin/virtualenvwrapper_lazy.sh
