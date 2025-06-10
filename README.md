# Daniel Santos' Dotfiles

Professional development environment configuration optimised for cross-platform productivity (macOS and Linux). Built for efficiency, automation, and seamless workflow integration.

## 🚀 Quick Installation

```bash
# Clone the repository
git clone https://github.com/drsntx/.dotfiles.git ~/.dotfiles

# Run the automated installation script
cd ~/.dotfiles && ./install.sh
```

The installation script automatically detects your operating system and installs all necessary dependencies.

## ✨ Key Features

### 🎯 Core Capabilities
- **Cross-Platform Compatibility**: Seamless operation on macOS and Linux distributions
- **Intelligent OS Detection**: Automatic configuration based on your system
- **Modular Architecture**: Organised configuration modules for easy maintenance
- **Automated Installation**: One-command setup with dependency management
- **Modern Tool Integration**: Contemporary replacements for traditional CLI tools
- **Professional Workflow**: Optimised for development and system administration

### 🛠️ Included Modern Tools

| Tool | Replaces | Purpose |
|------|----------|---------|
| `eza` | `ls` | Enhanced file listing with icons and git integration |
| `bat` | `cat` | Syntax-highlighted file viewer with line numbers |
| `fd` | `find` | Fast and intuitive file search with regex support |
| `ripgrep` | `grep` | Ultra-fast text search across files |
| `fzf` | - | Fuzzy finder for files, history, and command completion |
| `starship` | - | Fast, customisable cross-shell prompt |

### 🔧 Framework Integration
- **Oh My Zsh**: Complete framework with curated plugins
- **Starship Prompt**: Modern prompt with git status and system information
- **1Password Integration**: Secure SSH key and credential management
- **FZF Integration**: Enhanced command-line navigation and search

## 🏗️ Project Structure

```
.dotfiles/
├── install.sh                   # Automated installation script
├── dot_zshrc                    # Main Zsh configuration
├── README.md                    # This documentation
├── .gitignore                   # Git ignore patterns
├── zsh/
│   └── zsh.d/                   # Modular configuration files
│       ├── os_detection.zsh     # Operating system detection
│       ├── aliases.zsh          # Command aliases and shortcuts
│       ├── functions.zsh        # Custom shell functions
│       ├── history.zsh          # History configuration
│       ├── paths.zsh            # PATH and environment management
│       ├── plugins.zsh          # Plugin configuration and loading
│       └── init.zsh             # Final initialisation steps
├── starship/
│   └── starship.toml           # Prompt configuration
├── config/
│   ├── 1Password/              # 1Password SSH agent configuration
│   └── op/                     # 1Password CLI integration
├── ansible/                    # Ansible configuration files
│   ├── ansible.cfg             # Ansible settings
│   └── hosts                   # Inventory configuration
└── clean_history.zsh           # History cleaning utility
```

## 📋 System Requirements

### Essential Dependencies
- **Zsh 5.0+** - Primary shell environment
- **Git 2.0+** - Version control system
- **Curl** - HTTP client for downloads
- **Internet Connection** - For package installation

### Supported Operating Systems
- **macOS** - Intel and Apple Silicon (M1/M2/M3)
- **Ubuntu** - 18.04 LTS and newer
- **Debian** - 10 (Buster) and newer
- **Fedora** - 30 and newer
- **Arch Linux** - Rolling release
- **CentOS/RHEL** - 8 and newer

### Automatically Installed Tools
- Oh My Zsh framework with essential plugins
- Starship prompt with custom configuration
- Modern CLI tools (eza, bat, fd, ripgrep, fzf)
- Zsh plugins (autosuggestions, syntax highlighting, history search)

## 📦 Installation Methods

### Method 1: Automated Installation (Recommended)
```bash
# Single command installation
curl -fsSL https://raw.githubusercontent.com/drsntx/.dotfiles/main/install.sh | bash
```

### Method 2: Manual Installation
For users who prefer step-by-step control:

#### Step 1: Clone Repository
```bash
git clone https://github.com/drsntx/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

#### Step 2: Install Dependencies by Platform

**macOS (Homebrew)**
```bash
# Install Homebrew if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install zsh git starship eza bat fd ripgrep fzf
```

**Ubuntu/Debian**
```bash
sudo apt update
sudo apt install zsh git curl build-essential

# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Install eza
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update && sudo apt install eza

# Install remaining tools
sudo apt install bat fd-find ripgrep fzf
```

**Fedora**
```bash
sudo dnf install zsh git curl gcc gcc-c++ make
curl -sS https://starship.rs/install.sh | sh
sudo dnf install eza bat fd-find ripgrep fzf
```

**Arch Linux**
```bash
sudo pacman -S zsh git curl base-devel
curl -sS https://starship.rs/install.sh | sh
sudo pacman -S eza bat fd ripgrep fzf
```

#### Step 3: Install Oh My Zsh and Plugins
```bash
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install essential plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
```

#### Step 4: Create Symbolic Links
```bash
# Backup existing configuration
[[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.backup

# Create symlinks
ln -sf ~/.dotfiles/dot_zshrc ~/.zshrc
mkdir -p ~/.config/starship
ln -sf ~/.dotfiles/starship/starship.toml ~/.config/starship/starship.toml
```

#### Step 5: Set Default Shell
```bash
chsh -s $(which zsh)
```

## ⚙️ Configuration Modules

### OS Detection (`os_detection.zsh`)
Automatically detects your operating system and configures platform-specific settings:
- **macOS**: Homebrew paths for both Intel and Apple Silicon
- **Linux**: Distribution-specific package manager integration
- **Cross-platform**: Universal tool configuration

### Aliases (`aliases.zsh`)
Comprehensive alias collection organised by category:

**File Operations**
- `ll` - Detailed file listing with eza
- `la` - All files with detailed information
- `lt` - Tree view of directories
- `..`, `...` - Quick directory navigation

**Git Shortcuts**
- `g` - Git command shortcut
- `ga` - Git add
- `gc` - Git commit
- `gp` - Git push
- `gst` - Git status
- `glog` - Pretty git log

**Development Tools**
- `python` → `python3`
- `pip` → `pip3`
- `d` - Docker shortcut
- `dc` - Docker Compose

**System Management**
- `reload` - Reload shell configuration
- `c` - Clear screen
- Platform-specific package manager shortcuts

### Functions (`functions.zsh`)
Productivity-enhancing shell functions:

**File Management**
- `mkcd()` - Create directory and navigate to it
- `extract()` - Universal archive extraction
- `backup()` - Create timestamped file backups

**Development Utilities**
- `serve()` - Quick HTTP server for testing
- `genpass()` - Generate secure passwords
- `myip()` - Display public and local IP addresses

**System Information**
- `sysinfo()` - Comprehensive system information
- `weather()` - Current weather information
- `clean_history()` - Clean and optimise shell history

### Plugin Management (`plugins.zsh`)
Intelligent plugin loading with error handling:
- **Autosuggestions**: History-based command suggestions
- **Syntax Highlighting**: Real-time command syntax validation
- **History Search**: Intelligent history substring search
- **FZF Integration**: Enhanced file and command search

### Path Management (`paths.zsh`)
Intelligent PATH configuration:
- Cross-platform path detection
- Development tool integration (Rust, Go, Node.js, Python)
- XDG Base Directory compliance
- Environment variable management

## 🎨 Customisation

### Local Configuration Files
Create these files for personal customisations that won't be version controlled:

**`~/.zshrc.local`** - Personal Zsh configuration
```bash
# Custom environment variables
export WORK_PROJECT_PATH="/path/to/work/projects"
export PERSONAL_API_KEY="your-api-key"

# Custom functions
work() { cd "$WORK_PROJECT_PATH" }
```

**`~/.aliases.local`** - Personal aliases
```bash
# Project shortcuts
alias work='cd ~/Projects/work'
alias personal='cd ~/Projects/personal'

# Custom commands
alias deploy='./scripts/deploy.sh'
```

**`~/.env.local`** - Environment variables
```bash
export CUSTOM_VAR="value"
export API_ENDPOINT="https://api.example.com"
```

### Starship Prompt Customisation
Edit `~/.dotfiles/starship/starship.toml` to customise your prompt:
- OS icons and system information
- Git branch and status indicators
- Command execution time
- Python virtual environment display
- Docker context information

## 🔐 1Password Integration

### SSH Key Management
Automatic SSH key management through 1Password:
1. Install 1Password and 1Password CLI
2. Configure SSH agent in 1Password settings
3. SSH keys are automatically loaded and managed

### CLI Integration
Secure command execution with 1Password:
```bash
# Homebrew with 1Password integration
alias brew="op plugin run -- brew"
```

## 🔄 Maintenance and Updates

### Update Dotfiles
```bash
cd ~/.dotfiles
git pull origin main
source ~/.zshrc
```

### Update System Dependencies

**macOS**
```bash
brew update && brew upgrade && brew cleanup
```

**Ubuntu/Debian**
```bash
sudo apt update && sudo apt upgrade
```

**Fedora**
```bash
sudo dnf update
```

**Arch Linux**
```bash
sudo pacman -Syu
```

### Clean Shell History
```bash
# Use the built-in function
clean_history

# Or run the script directly
~/.dotfiles/clean_history.zsh
```

## 🚨 Troubleshooting

### Common Issues and Solutions

**Zsh Not Default Shell**
```bash
# Check available shells
cat /etc/shells

# Set Zsh as default
chsh -s $(which zsh)
```

**Plugins Not Loading**
```bash
# Verify Oh My Zsh installation
ls -la ~/.oh-my-zsh

# Reinstall plugins if needed
cd ~/.oh-my-zsh/custom/plugins
rm -rf zsh-*
# Re-run plugin installation commands
```

**Starship Prompt Missing**
```bash
# Check installation
which starship

# Verify configuration
echo $STARSHIP_CONFIG

# Reinstall if needed
curl -sS https://starship.rs/install.sh | sh
```

**Modern Tools Not Found**
```bash
# Check tool availability
which eza bat fd rg fzf

# Reinstall based on your system
# Follow platform-specific installation instructions
```

### Debug Mode
For detailed troubleshooting:
```bash
# Run with debug output
zsh -x ~/.zshrc

# Check specific module loading
source ~/.dotfiles/zsh/zsh.d/aliases.zsh
```

## 🤝 Contributing

This is a personal dotfiles repository, but contributions are welcome:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/improvement`)
3. **Commit** your changes (`git commit -am 'Add improvement'`)
4. **Push** to the branch (`git push origin feature/improvement`)
5. **Create** a Pull Request

### Contribution Guidelines
- Maintain cross-platform compatibility
- Follow existing code style and organisation
- Test changes on multiple systems when possible
- Update documentation for new features

## 📄 Licence

Personal configuration files distributed under MIT licence. Use at your own discretion.

## 📞 Support

- **Issues**: Report bugs and request features via GitHub Issues
- **Discussions**: General questions and suggestions via GitHub Discussions
- **Documentation**: Additional guides available in the repository wiki

---

**Author**: Daniel Santos  
**Role**: IT Architect Specialist
**Contact**: [GitHub Profile](https://github.com/drsntx)  
**Last Updated**: June 2025

*Optimised for productivity, built for professionals.*

