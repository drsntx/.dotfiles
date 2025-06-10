# Useful Functions for Enhanced Productivity
# Collection of handy shell functions

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick HTTP server
serve() {
    local port=${1:-8000}
    echo "Starting HTTP server on port $port..."
    echo "Access at: http://localhost:$port"
    python3 -m http.server "$port"
}

# Generate random password
genpass() {
    local length=${1:-16}
    if command -v openssl >/dev/null 2>&1; then
        openssl rand -base64 "$length" | tr -d "=+/" | cut -c1-"$length"
    else
        cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "$length" | head -n 1
    fi
}

# Get public IP
myip() {
    echo "Public IP:"
    curl -s https://ifconfig.me
    echo
    
    echo "Local IP:"
    if [[ "$DOTFILES_OS" == "macos" ]]; then
        ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}'
    else
        hostname -I | cut -d' ' -f1
    fi
}

# System information
sysinfo() {
    echo "System Information:"
    echo "=================="
    echo "OS: $(uname -s)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    
    if [[ "$DOTFILES_OS" == "linux" ]]; then
        if [[ -f /etc/os-release ]]; then
            echo "Distribution: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
        fi
    elif [[ "$DOTFILES_OS" == "macos" ]]; then
        echo "macOS Version: $(sw_vers -productVersion)"
    fi
    
    echo "Hostname: $(hostname)"
}

# Weather function
weather() {
    local location=${1:-""}
    if [[ -n "$location" ]]; then
        curl -s "wttr.in/$location?format=3"
    else
        curl -s "wttr.in/?format=3"
    fi
}

# Clean Zsh history
clean_history() {
    local hist_file="${HISTFILE:-$ZDOTDIR/.zsh_history}"
    local backup_file="$hist_file.backup.$(date +%Y%m%d_%H%M%S)"
    
    if [[ -f "$hist_file" ]]; then
        echo "Creating backup: $backup_file"
        cp "$hist_file" "$backup_file"
        
        echo "Cleaning history file..."
        sed 's/^: [0-9]*:[0-9]*;//' "$backup_file" > "$hist_file.clean"
        mv "$hist_file.clean" "$hist_file"
        
        echo "History cleaned successfully!"
        echo "Backup saved as: $backup_file"
    else
        echo "History file not found: $hist_file"
    fi
}