# Shell Initialization
# Final initialization steps

# Load Homebrew environment variables (macOS only)
if [[ "$DOTFILES_OS" == "macos" ]]; then
    if [[ -d "/opt/homebrew/bin" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -d "/usr/local/bin/brew" ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi

# Initialize Starship prompt (if available)
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
else
    echo "⚠️  Starship not found. Install with: curl -sS https://starship.rs/install.sh | sh"
fi