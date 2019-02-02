# Setup fzf
# ---------
if [[ ! "$PATH" == */home/benjamin/.fzf/bin* ]]; then
  export PATH="$PATH:/home/benjamin/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/benjamin/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/benjamin/.fzf/shell/key-bindings.bash"

