# OS Detection and Platform-specific configurations
# This file should be sourced first in the zsh.d directory

# Detect operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    export DOTFILES_OS="macos"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export DOTFILES_OS="linux"
else
    export DOTFILES_OS="unknown"
fi

# Detect Linux distribution
if [[ "$DOTFILES_OS" == "linux" ]]; then
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        export DOTFILES_DISTRO="$ID"
    else
        export DOTFILES_DISTRO="unknown"
    fi
fi

# Platform-specific PATH configurations
case "$DOTFILES_OS" in
    "macos")
        # Homebrew paths
        if [[ -d "/opt/homebrew/bin" ]]; then
            # Apple Silicon Mac
            export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
            export HOMEBREW_PREFIX="/opt/homebrew"
        elif [[ -d "/usr/local/bin/brew" ]]; then
            # Intel Mac
            export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
            export HOMEBREW_PREFIX="/usr/local"
        fi
        
        # Add Homebrew completions
        if [[ -n "$HOMEBREW_PREFIX" ]]; then
            fpath+=("$HOMEBREW_PREFIX/share/zsh/site-functions")
        fi
        ;;
    "linux")
        # Linux-specific paths
        export PATH="$HOME/.local/bin:$PATH"
        
        # Distribution-specific configurations
        case "$DOTFILES_DISTRO" in
            "ubuntu"|"debian")
                # Ubuntu/Debian specific settings
                ;;
            "fedora")
                # Fedora specific settings
                ;;
            "arch"|"manjaro")
                # Arch specific settings
                ;;
        esac
        ;;
esac

# Common paths for all systems
export PATH="$HOME/.local/bin:$PATH"

# Starship configuration path
export STARSHIP_CONFIG="$HOME/.dotfiles/starship/starship.toml"