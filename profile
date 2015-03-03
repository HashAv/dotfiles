# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
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
