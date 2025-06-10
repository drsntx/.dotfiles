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
alias .....='cd ../../../..'
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
else
    alias cat='cat -n'
fi

if command -v fd >/dev/null 2>&1; then
    alias find='fd'
fi

if command -v rg >/dev/null 2>&1; then
    alias grep='rg'
else
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Python aliases
alias python='python3'
alias pip='pip3'
alias py='python3'
alias venv='python3 -m venv'
alias activate='source venv/bin/activate'

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git commit -a -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git pull'
alias gp='git push'
alias gst='git status'
alias gss='git status -s'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dcu='docker-compose up'
alias dcd='docker-compose down'
alias dcb='docker-compose build'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dprune='docker system prune -f'

# Kubernetes aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
alias kaf='kubectl apply -f'
alias kdel='kubectl delete'
alias klog='kubectl logs'
alias kexec='kubectl exec -it'

# System monitoring
if command -v htop >/dev/null 2>&1; then
    alias top='htop'
fi

# Network
alias ping='ping -c 5'
alias ports='netstat -tulanp'
alias myip='curl -s https://ifconfig.me'
alias localip='hostname -I | cut -d" " -f1'

# Disk usage
alias du='du -h'
alias df='df -h'
alias free='free -h'

# Process management
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias killall='killall -v'

# Archive operations
alias tar='tar -v'
alias untar='tar -xvf'
alias targz='tar -czvf'
alias untargz='tar -xzvf'

# Quick edits
alias zshrc='${EDITOR:-nano} ~/.zshrc'
alias aliases='${EDITOR:-nano} ~/.dotfiles/zsh/zsh.d/aliases.zsh'
alias hosts='sudo ${EDITOR:-nano} /etc/hosts'

# Quick navigation to common directories
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias docs='cd ~/Documents'
alias proj='cd ~/Projects'
alias dot='cd ~/.dotfiles'

# System information
alias sysinfo='uname -a'
alias distro='cat /etc/os-release'
alias kernel='uname -r'

# Reload shell
alias reload='source ~/.zshrc'
alias rl='source ~/.zshrc'

# History
alias h='history'
alias hg='history | grep'

# Clear screen
alias c='clear'
alias cls='clear'

# Weather (requires curl)
alias weather='curl -s "wttr.in/?format=3"'
alias forecast='curl -s "wttr.in"'

# Quick server
alias serve='python3 -m http.server 8000'

# Platform-specific aliases
case "$DOTFILES_OS" in
    "macos")
        # macOS specific aliases
        alias brewup='brew update && brew upgrade && brew cleanup'
        alias flushdns='sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
        alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
        alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'
        alias spotlight-off='sudo mdutil -a -i off'
        alias spotlight-on='sudo mdutil -a -i on'
        ;;
    "linux")
        # Linux specific aliases
        case "$DOTFILES_DISTRO" in
            "ubuntu"|"debian")
                alias aptup='sudo apt update && sudo apt upgrade'
                alias aptin='sudo apt install'
                alias aptse='apt search'
                alias aptsh='apt show'
                ;;
            "fedora")
                alias dnfup='sudo dnf update'
                alias dnfin='sudo dnf install'
                alias dnfse='dnf search'
                ;;
            "arch"|"manjaro")
                alias pacup='sudo pacman -Syu'
                alias pacin='sudo pacman -S'
                alias pacse='pacman -Ss'
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

