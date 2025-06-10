# Enhanced Aliases Configuration
# Comprehensive set of aliases for productivity

# File operations with eza (modern ls replacement)
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons'
    alias ll='eza --all --long --group --group-directories-first --icons --header --time-style long-iso'
    alias la='eza --all --long --group --group-directories-first --icons --header'
    alias lt='eza --tree --level=2 --icons'
    alias lta='eza --tree --all --level=2 --icons'
else
    # Fallback to regular ls with colors
    alias ls='ls --color=auto'
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'
fi

# File operations
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Safe file operations
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Directory operations
alias mkdir='mkdir -pv'
alias md='mkdir -pv'

# Text operations with modern tools
if command -v bat >/dev/null 2>&1; then
    alias cat='bat'
    alias less='bat'
fi

if command -v fd >/dev/null 2>&1; then
    alias find='fd'
fi

if command -v rg >/dev/null 2>&1; then
    alias grep='rg'
else
    alias grep='grep --color=auto'
fi

# Python aliases
alias python='python3'
alias pip='pip3'
alias py='python3'

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias glog='git log --oneline --decorate --graph'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'

# System monitoring
if command -v htop >/dev/null 2>&1; then
    alias top='htop'
fi

# Network
alias ping='ping -c 5'
alias myip='curl -s https://ifconfig.me'

# Quick edits
alias zshrc='${EDITOR:-nano} ~/.zshrc'
alias reload='source ~/.zshrc'

# Clear screen
alias c='clear'
alias cls='clear'

# Platform-specific aliases
case "$DOTFILES_OS" in
    "macos")
        # macOS specific aliases
        alias brewup='brew update && brew upgrade && brew cleanup'
        ;;
    "linux")
        # Linux specific aliases
        case "$DOTFILES_DISTRO" in
            "ubuntu"|"debian")
                alias aptup='sudo apt update && sudo apt upgrade'
                alias aptin='sudo apt install'
                ;;
            "fedora")
                alias dnfup='sudo dnf update'
                alias dnfin='sudo dnf install'
                ;;
            "arch"|"manjaro")
                alias pacup='sudo pacman -Syu'
                alias pacin='sudo pacman -S'
                ;;
        esac
        
        # Common Linux aliases
        alias open='xdg-open'
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
        ;;
esac

# Load local aliases if they exist
[[ -f "$HOME/.aliases.local" ]] && source "$HOME/.aliases.local"