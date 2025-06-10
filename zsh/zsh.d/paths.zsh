# Enhanced PATH Management and Environment Variables
# Cross-platform PATH configuration with proper detection

# Function to safely add to PATH
add_to_path() {
    local dir="$1"
    if [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$dir:$PATH"
    fi
}

# Function to safely add to end of PATH
append_to_path() {
    local dir="$1"
    if [[ -d "$dir" && ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$PATH:$dir"
    fi
}

# User local binaries (highest priority)
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/bin"

# Platform-specific PATH management
case "$DOTFILES_OS" in
    "macos")
        # Homebrew paths (detect Apple Silicon vs Intel)
        if [[ -d "/opt/homebrew" ]]; then
            # Apple Silicon Mac
            eval "$(/opt/homebrew/bin/brew shellenv)"
            add_to_path "/opt/homebrew/bin"
            add_to_path "/opt/homebrew/sbin"
            export HOMEBREW_PREFIX="/opt/homebrew"
        elif [[ -d "/usr/local/Homebrew" ]]; then
            # Intel Mac
            eval "$(/usr/local/bin/brew shellenv)"
            add_to_path "/usr/local/bin"
            add_to_path "/usr/local/sbin"
            export HOMEBREW_PREFIX="/usr/local"
        fi
        
        # macOS system paths
        add_to_path "/usr/local/bin"
        add_to_path "/usr/local/sbin"
        
        # MacPorts (if installed)
        add_to_path "/opt/local/bin"
        add_to_path "/opt/local/sbin"
        ;;
        
    "linux")
        # Standard Linux paths
        add_to_path "/usr/local/bin"
        add_to_path "/usr/local/sbin"
        
        # Snap packages
        add_to_path "/snap/bin"
        
        # Flatpak
        add_to_path "/var/lib/flatpak/exports/bin"
        add_to_path "$HOME/.local/share/flatpak/exports/bin"
        
        # Distribution-specific paths
        case "$DOTFILES_DISTRO" in
            "arch"|"manjaro")
                # Arch Linux specific paths
                ;;
            "ubuntu"|"debian")
                # Ubuntu/Debian specific paths
                ;;
            "fedora")
                # Fedora specific paths
                ;;
        esac
        ;;
esac

# Development tools paths
add_to_path "$HOME/.cargo/bin"              # Rust
add_to_path "$HOME/.go/bin"                 # Go
add_to_path "$HOME/.npm-global/bin"         # npm global
add_to_path "$HOME/.yarn/bin"               # Yarn
add_to_path "$HOME/.composer/vendor/bin"    # PHP Composer
add_to_path "$HOME/.gem/bin"                # Ruby gems

# Python paths
if command -v python3 >/dev/null 2>&1; then
    # Python user base
    PYTHON_USER_BASE=$(python3 -m site --user-base 2>/dev/null)
    if [[ -n "$PYTHON_USER_BASE" ]]; then
        add_to_path "$PYTHON_USER_BASE/bin"
    fi
fi

# Node.js version managers
add_to_path "$HOME/.nvm/current/bin"        # nvm
add_to_path "$HOME/.fnm"                    # fnm
add_to_path "$HOME/.volta/bin"              # volta

# Java paths
if [[ -n "$JAVA_HOME" ]]; then
    add_to_path "$JAVA_HOME/bin"
fi

# Android SDK
if [[ -d "$HOME/Android/Sdk" ]]; then
    export ANDROID_HOME="$HOME/Android/Sdk"
    add_to_path "$ANDROID_HOME/tools"
    add_to_path "$ANDROID_HOME/tools/bin"
    add_to_path "$ANDROID_HOME/platform-tools"
fi

# Flutter
add_to_path "$HOME/flutter/bin"

# Dotfiles scripts
add_to_path "$HOME/.dotfiles/bin"

# Environment Variables
export EDITOR="${EDITOR:-nano}"
export VISUAL="${VISUAL:-$EDITOR}"
export PAGER="${PAGER:-less}"
export BROWSER="${BROWSER:-}"

# Set browser based on OS
if [[ -z "$BROWSER" ]]; then
    case "$DOTFILES_OS" in
        "macos")
            export BROWSER="open"
            ;;
        "linux")
            export BROWSER="xdg-open"
            ;;
    esac
fi

# Language and locale
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"

# Less configuration
export LESS="-R -i -M -S -x4"
export LESSHISTFILE="$HOME/.cache/less_history"

# Grep colors
export GREP_COLOR="1;32"

# LS colors (if not using eza)
if [[ "$DOTFILES_OS" == "linux" ]]; then
    export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
fi

# FZF configuration
export FZF_DEFAULT_OPTS="
    --height 40% 
    --layout=reverse 
    --border 
    --preview 'bat --style=numbers --color=always --line-range :500 {}' 
    --preview-window=right:50%:wrap
    --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

# Use fd for FZF if available
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# Starship prompt configuration
export STARSHIP_CONFIG="$HOME/.dotfiles/starship/starship.toml"

# History configuration (moved from history.zsh for better organization)
export HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000

# XDG Base Directory Specification
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Create XDG directories if they don't exist
mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_STATE_HOME"

# Tool-specific configurations using XDG
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"

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

