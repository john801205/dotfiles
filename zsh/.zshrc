# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# Vi mode
bindkey -v

autoload -U compinit; compinit

autoload -U +X bashcompinit && bashcompinit
if type terraform &>/dev/null; then
	complete -o nospace -C /opt/homebrew/bin/terraform terraform
fi

autoload -Uz edit-command-line
zle -N edit-command-line

# Enable fzf integration
if type fzf &>/dev/null; then
	source <(fzf --zsh)
fi

# fzf-tab
if [ -f '/opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh' ]; then . '/opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh'; fi

# Enable k9s completion
if type k9s &>/dev/null; then
	source <(k9s completion zsh)
fi

# Enable rust completion
if type rustup &>/dev/null; then
	source <(rustup completions zsh)
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi
