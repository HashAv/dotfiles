# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="bira"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# This interfers with tmux titles as well so turning it off
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git bundler heroku)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
setopt noautomenu
# setopt nomenucomplete
setopt nocorrect
setopt nocorrectall

export CHROMIUM_USER_FLAGS=--password-store=detect

# This is bash specific
# Have vi behaviour
# set -o vi
# bind -m vi-insert "\C-l":clear-screen                 # ^l clear screen
# bind -m vi-insert "\C-n":menu-complete                # ^n cycle through the list of partial matches
# bind -m vi-insert "\C-p":menu-complete-krd            # ^p cycle through the list of partial matches, backwards
# bind -m vi-insert "\C-g":vi-movement-mode             # Other keys ^c, ^v, ^q, ^s don't work !
# bind -m vi-insert 'Control-a: beginning-of-line'      # Ctrl-A: insert at line start like in emacs mode
# bind -m vi-insert 'Control-e: end-of-line'            # Ctrl-E: append at line end like in emacs mode

# Needed for vim <C-S> mapping
# stty -ixon
# bindkey -v
# bindkey "^P" vi-up-line-or-history
# bindkey "^N" vi-down-line-or-history

# bindkey "^[[1~" vi-beginning-of-line   # Home
# bindkey "^[[4~" vi-end-of-line         # End
# bindkey '^[[2~' beep                   # Insert
# bindkey '^[[3~' delete-char            # Del
# bindkey '^[[5~' vi-backward-blank-word # Page Up
# bindkey '^[[6~' vi-forward-blank-word  # Page Down

