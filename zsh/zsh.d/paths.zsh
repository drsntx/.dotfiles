# Enhanced PATH Management and Environment Variables
# Cross-platform PATH configuration with proper detection

# Function to safely add to PATH
add_to_path() {
    local dir="$1"
    if [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$dir:$PATH"
    fi
}

# User local binaries (highest priority)
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/bin"

# Development tools paths
add_to_path "$HOME/.cargo/bin"              # Rust
add_to_path "$HOME/.go/bin"                 # Go
add_to_path "$HOME/.npm-global/bin"         # npm global
add_to_path "$HOME/.yarn/bin"               # Yarn

# Environment Variables
export EDITOR="${EDITOR:-nano}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less}"

# Set browser based on OS
case "$DOTFILES_OS" in
    "macos")
        export BROWSER="open"
        ;;
    "linux")
        export BROWSER="xdg-open"
        ;;
esac

# Language and locale
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"

# Less configuration
export LESS="-R -i -M -S -x4"

# FZF configuration
export FZF_DEFAULT_OPTS="
    --height 40% 
    --layout=reverse 
    --border 
    --preview 'bat --style=numbers --color=always --line-range :500 {}' 
    --preview-window=right:50%:wrap
"

# Use fd for FZF if available
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Starship prompt configuration
export STARSHIP_CONFIG="$HOME/.dotfiles/starship/starship.toml"

# 1Password CLI configuration
if command -v op >/dev/null 2>&1; then
    # Source 1Password plugins if available
    [[ -f "$HOME/.dotfiles/config/op/plugins.sh" ]] && source "$HOME/.dotfiles/config/op/plugins.sh"
fi

# SSH agent configuration for 1Password
if [[ -S "$HOME/.1password/agent.sock" ]]; then
    export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
fi

# Load local environment variables if they exist
[[ -f "$HOME/.env.local" ]] && source "$HOME/.env.local"