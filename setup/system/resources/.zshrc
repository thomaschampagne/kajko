# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory      # Append to history instead of overwriting
setopt sharehistory       # Share history across multiple open terminals
setopt histignorealldups  # Ignore duplicated commands

# Vim mode
bindkey -v
bindkey 'jj' vi-cmd-mode
bindkey '^[[3~' delete-char
bindkey '^R' history-incremental-search-backward # TODO Also support reverse with shift pressed
bindkey '^?' backward-delete-char

# TODO Drop emacs below shortcuts ?
# # -----------------------------------------------------------------------------
# # Emacs Terminal key bindings for arrows (Bash-like behavior)
# # -----------------------------------------------------------------------------

# bindkey -e

# # Delete key
# # ^[[3~ → Delete character under cursor
# bindkey '^[[3~' delete-char

# # Home key
# # ^[[H → Move cursor to beginning of line
# bindkey '^[[H' beginning-of-line

# # End key
# # ^[[F → Move cursor to end of line
# bindkey '^[[F' end-of-line

# # Ctrl + Left Arrow  (^[[1;5D) → jump backward one word
# bindkey '^[[1;5D' backward-word

# # Ctrl + Right Arrow (^[[1;5C) → jump forward one word
# bindkey '^[[1;5C' forward-word

# # Alt + Left Arrow  (^[[1;3D) → jump backward one word
# bindkey '^[[1;3D' backward-word

# # Alt + Right Arrow (^[[1;3C) → jump forward one word
# bindkey '^[[1;3C' forward-word

# # TODO Drop cause of shift tab not working ??!!
# # Shift + Left Arrow  (^[[1;2D) → move cursor left
# bindkey '^[[1;2D' backward-char

# # Shift + Right Arrow (^[[1;2C) → move cursor right
# bindkey '^[[1;2C' forward-char

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dev/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Loading Fedora Native Plugins
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ll='ls -lFh'
alias la='ls -lAFh'
alias vi='nvim'
alias vim='nvim'

# Default PATH
eval "$(mise activate --shims)" # Will export mise shim to PATH
