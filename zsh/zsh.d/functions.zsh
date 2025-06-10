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
            *.xz)        unxz "$1"        ;;
            *.lzma)      unlzma "$1"      ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find file by name
ff() {
    if command -v fd >/dev/null 2>&1; then
        fd "$1"
    else
        find . -name "*$1*" -type f
    fi
}

# Find directory by name
fd_dir() {
    if command -v fd >/dev/null 2>&1; then
        fd -t d "$1"
    else
        find . -name "*$1*" -type d
    fi
}

# Search in files
search() {
    if command -v rg >/dev/null 2>&1; then
        rg "$1"
    else
        grep -r "$1" .
    fi
}

# Get file size
filesize() {
    if [[ -f "$1" ]]; then
        if [[ "$DOTFILES_OS" == "macos" ]]; then
            stat -f%z "$1" | numfmt --to=iec
        else
            stat -c%s "$1" | numfmt --to=iec
        fi
    else
        echo "File not found: $1"
    fi
}

# Create backup of file
backup() {
    if [[ -f "$1" ]]; then
        cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backup created: $1.backup.$(date +%Y%m%d_%H%M%S)"
    else
        echo "File not found: $1"
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

# Port checker
port_check() {
    local host=${1:-localhost}
    local port=$2
    
    if [[ -z "$port" ]]; then
        echo "Usage: port_check [host] <port>"
        return 1
    fi
    
    if command -v nc >/dev/null 2>&1; then
        nc -z "$host" "$port" && echo "Port $port is open on $host" || echo "Port $port is closed on $host"
    else
        timeout 3 bash -c "</dev/tcp/$host/$port" && echo "Port $port is open on $host" || echo "Port $port is closed on $host"
    fi
}

# Git functions
git_clean_branches() {
    echo "Cleaning up merged branches..."
    git branch --merged | grep -v "\*\|main\|master\|develop" | xargs -n 1 git branch -d
}

git_size() {
    echo "Repository size:"
    du -sh .git
    echo
    echo "Largest files:"
    git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | sed -n 's/^blob //p' | sort --numeric-sort --key=2 | tail -10
}

# Docker functions
docker_cleanup() {
    echo "Cleaning up Docker..."
    docker system prune -f
    docker volume prune -f
    docker image prune -a -f
}

docker_stats() {
    echo "Docker system information:"
    docker system df
    echo
    echo "Running containers:"
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# System information
sysinfo() {
    echo "System Information:"
    echo "=================="
    echo "OS: $(uname -s)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    
    if [[ "$DOTFILES_OS" == "linux" ]]; then
        echo "Distribution: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
    elif [[ "$DOTFILES_OS" == "macos" ]]; then
        echo "macOS Version: $(sw_vers -productVersion)"
    fi
    
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime | awk -F'up ' '{print $2}' | awk -F', load' '{print $1}')"
    echo "Memory: $(free -h 2>/dev/null | grep Mem | awk '{print $3 "/" $2}' || echo "N/A")"
    echo "Disk Usage: $(df -h / | tail -1 | awk '{print $3 "/" $2 " (" $5 " used)"}')"
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

# URL shortener using tinyurl
shorten() {
    if [[ -z "$1" ]]; then
        echo "Usage: shorten <URL>"
        return 1
    fi
    
    curl -s "http://tinyurl.com/api-create.php?url=$1"
    echo
}

# QR code generator (requires qrencode)
qr() {
    if [[ -z "$1" ]]; then
        echo "Usage: qr <text>"
        return 1
    fi
    
    if command -v qrencode >/dev/null 2>&1; then
        qrencode -t UTF8 "$1"
    else
        echo "qrencode not installed. Install with:"
        case "$DOTFILES_OS" in
            "macos") echo "brew install qrencode" ;;
            "linux") echo "sudo apt install qrencode" ;;
        esac
    fi
}

# Convert video to GIF
vid2gif() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: vid2gif <input_video> <output_gif>"
        return 1
    fi
    
    if command -v ffmpeg >/dev/null 2>&1; then
        ffmpeg -i "$1" -vf "fps=10,scale=320:-1:flags=lanczos" -c:v gif "$2"
    else
        echo "ffmpeg not installed"
    fi
}

# Clean Zsh history (improved version of the existing script)
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

