export HISTFILE="$ZDOTDIR/.zsh_history" # Path to the history file
# Set the history file size and options
export HISTSIZE=10000000                # Maximum number of history entries in memory  
export SAVEHIST=10000000                # Maximum number of history entries to save to the history file

setopt INC_APPEND_HISTORY               # Append to the history file incrementally
setopt HIST_EXPIRE_DUPS_FIRST           # Expire duplicates first
setopt SHARE_HISTORY                    # Share history across all sessions
setopt HIST_IGNORE_ALL_DUPS             # Ignore all duplicates in the history file
setopt HIST_FIND_NO_DUPS                # Do not show duplicates when searching history
setopt HIST_IGNORE_SPACE                # Ignore commands that start with a space
setopt APPEND_HISTORY                   # Append to the history file instead of overwriting it
