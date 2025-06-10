#!/bin/bash

# Daniel Santos' Dotfiles Installation Script
# Supports macOS and Linux (Ubuntu/Debian/Fedora/Arch)

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect operating system
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        DISTRO="macos"
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        OS="linux"
        DISTRO=$ID
    else
        log_error "Unsupported operating system"
        exit 1
    fi
    
    log_info "Detected system: $OS ($DISTRO)"
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install package manager (Homebrew for macOS)
install_package_manager() {
    if [[ "$OS" == "macos" ]]; then
        if ! command_exists brew; then
            log_info "Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            
            # Add Homebrew to PATH for Apple Silicon Macs
            if [[ $(uname -m) == "arm64" ]]; then
                echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
                eval "$(/opt/homebrew/bin/brew shellenv)"
            else
                echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
                eval "$(/usr/local/bin/brew shellenv)"
            fi
        else
            log_success "Homebrew already installed"
        fi
    fi
}

# Update package lists
update_packages() {
    log_info "Updating package lists..."
    
    case $DISTRO in
        "ubuntu"|"debian")
            sudo apt update
            ;;
        "fedora")
            sudo dnf check-update || true
            ;;
        "arch"|"manjaro")
            sudo pacman -Sy
            ;;
        "macos")
            brew update
            ;;
    esac
}

# Install dependencies
install_dependencies() {
    log_info "Installing dependencies..."
    
    local packages=()
    
    case $DISTRO in
        "ubuntu"|"debian")
            packages=("zsh" "curl" "git" "build-essential")
            sudo apt install -y "${packages[@]}"
            ;;
        "fedora")
            packages=("zsh" "curl" "git" "gcc" "gcc-c++" "make")
            sudo dnf install -y "${packages[@]}"
            ;;
        "arch"|"manjaro")
            packages=("zsh" "curl" "git" "base-devel")
            sudo pacman -S --noconfirm "${packages[@]}"
            ;;
        "macos")
            packages=("zsh" "git")
            brew install "${packages[@]}"
            ;;
    esac
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        log_success "Oh My Zsh already installed"
    fi
}

# Install Oh My Zsh plugins
install_zsh_plugins() {
    log_info "Installing Oh My Zsh plugins..."
    
    local plugin_dir="$HOME/.oh-my-zsh/custom/plugins"
    
    # zsh-autosuggestions
    if [[ ! -d "$plugin_dir/zsh-autosuggestions" ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions "$plugin_dir/zsh-autosuggestions"
    fi
    
    # zsh-syntax-highlighting
    if [[ ! -d "$plugin_dir/zsh-syntax-highlighting" ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting "$plugin_dir/zsh-syntax-highlighting"
    fi
    
    # history-substring-search
    if [[ ! -d "$plugin_dir/zsh-history-substring-search" ]]; then
        git clone https://github.com/zsh-users/zsh-history-substring-search "$plugin_dir/zsh-history-substring-search"
    fi
}

# Install Starship prompt
install_starship() {
    if ! command_exists starship; then
        log_info "Installing Starship prompt..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
    else
        log_success "Starship already installed"
    fi
}

# Install modern CLI tools
install_modern_tools() {
    log_info "Installing modern CLI tools..."
    
    case $DISTRO in
        "ubuntu"|"debian")
            # eza (modern ls)
            if ! command_exists eza; then
                wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
                echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
                sudo apt update
                sudo apt install -y eza
            fi
            
            # bat (modern cat)
            sudo apt install -y bat
            # Create symlink if bat is installed as batcat
            if command_exists batcat && ! command_exists bat; then
                mkdir -p ~/.local/bin
                ln -sf /usr/bin/batcat ~/.local/bin/bat
            fi
            
            # fd (modern find)
            sudo apt install -y fd-find
            # Create symlink
            if command_exists fdfind && ! command_exists fd; then
                mkdir -p ~/.local/bin
                ln -sf /usr/bin/fdfind ~/.local/bin/fd
            fi
            
            # ripgrep
            sudo apt install -y ripgrep
            
            # fzf
            sudo apt install -y fzf
            ;;
        "fedora")
            sudo dnf install -y eza bat fd-find ripgrep fzf
            ;;
        "arch"|"manjaro")
            sudo pacman -S --noconfirm eza bat fd ripgrep fzf
            ;;
        "macos")
            brew install eza bat fd ripgrep fzf
            ;;
    esac
}

# Clone or update dotfiles repository
setup_dotfiles() {
    local dotfiles_dir="$HOME/.dotfiles"
    
    if [[ -d "$dotfiles_dir" ]]; then
        log_info "Updating existing dotfiles..."
        cd "$dotfiles_dir"
        git pull origin main || git pull origin master
    else
        log_info "Cloning dotfiles repository..."
        git clone https://github.com/drsntx/.dotfiles.git "$dotfiles_dir"
    fi
}

# Create symlinks
create_symlinks() {
    log_info "Creating symlinks..."
    
    local dotfiles_dir="$HOME/.dotfiles"
    
    # Backup existing files
    for file in .zshrc .zshenv; do
        if [[ -f "$HOME/$file" && ! -L "$HOME/$file" ]]; then
            log_warning "Backing up $HOME/$file to $HOME/$file.backup"
            mv "$HOME/$file" "$HOME/$file.backup"
        fi
    done
    
    # Create symlinks
    ln -sf "$dotfiles_dir/dot_zshrc" "$HOME/.zshrc"
    
    # Create config directories
    mkdir -p "$HOME/.config/starship"
    ln -sf "$dotfiles_dir/starship/starship.toml" "$HOME/.config/starship/starship.toml"
    
    # Create 1Password directories if needed
    if [[ -f "$dotfiles_dir/config/1Password/ssh/agent.toml" ]]; then
        mkdir -p "$HOME/.config/1Password/ssh"
        ln -sf "$dotfiles_dir/config/1Password/ssh/agent.toml" "$HOME/.config/1Password/ssh/agent.toml"
    fi
}

# Set Zsh as default shell
set_default_shell() {
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        log_info "Setting Zsh as default shell..."
        chsh -s "$(which zsh)"
        log_success "Zsh set as default shell. Restart terminal to apply changes."
    else
        log_success "Zsh is already the default shell"
    fi
}

# Main installation function
main() {
    echo "🚀 Daniel Santos' Dotfiles Installation"
    echo "======================================="
    echo
    
    detect_os
    install_package_manager
    update_packages
    install_dependencies
    install_oh_my_zsh
    install_zsh_plugins
    install_starship
    install_modern_tools
    setup_dotfiles
    create_symlinks
    set_default_shell
    
    echo
    log_success "✅ Installation completed successfully!"
    echo
    echo "📝 Next steps:"
    echo "1. Restart your terminal or run: source ~/.zshrc"
    echo "2. If you use 1Password, configure the SSH agent"
    echo "3. Customize settings in ~/.dotfiles as needed"
    echo
    echo "🔧 To update dotfiles in the future:"
    echo "cd ~/.dotfiles && git pull"
    echo
}

# Run main function
main "$@"