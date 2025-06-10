# Load Homebrew environment variables first
eval "$(/opt/homebrew/bin/brew shellenv)"

# Then initialize Starship
eval "$(starship init zsh)"