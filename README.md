# Daniel Santos' Dotfiles

Optimised personal configurations for cross-platform development (macOS and Linux) with focus on productivity and automation.

## 🚀 Quick Installation

```bash
# Clone the repository
git clone https://github.com/drsntx/.dotfiles.git ~/.dotfiles

# Run the installation script
cd ~/.dotfiles && ./install.sh
```

The script automatically detects your operating system and installs all necessary dependencies.

## 📋 Features

### ✨ Key Features

- **Modular Configuration**: Organised into logical modules for easy maintenance
- **Cross-Platform**: Works seamlessly on macOS and Linux
- **Automated Installation**: Intelligent script that detects OS and installs dependencies
- **Oh My Zsh Integration**: Complete framework with essential plugins
- **Starship Prompt**: Modern and fast prompt with Git integration
- **Modern Tools**: Contemporary replacements for traditional commands
- **1Password Integration**: Secure configuration for SSH and CLI

### 🔧 Included Tools

| Tool | Replaces | Description |
|------|----------|-------------|
| `eza` | `ls` | Modern file listing with icons |
| `bat` | `cat` | File viewer with syntax highlighting |
| `fd` | `find` | Fast and intuitive file search |
| `ripgrep` | `grep` | Ultra-fast text search |
| `fzf` | - | Fuzzy finder for history and files |
| `starship` | - | Customisable cross-shell prompt |

## 🏗️ Project Structure

```
.dotfiles/
├── install.sh                   # Automated installation script
├── dot_zshrc                    # Main Zsh configuration
├── zsh/
│   └── zsh.d/                   # Configuration modules
│       ├── os_detection.zsh     # Operating system detection
│       ├── aliases.zsh          # Custom aliases
│       ├── functions.zsh        # Useful functions
│       ├── history.zsh          # History configuration
│       ├── paths.zsh            # PATH management
│       ├── plugins.zsh          # Plugin configuration
│       └── init.zsh             # Shell initialisation
├── starship/
│   └── starship.toml           # Prompt configuration
├── config/
│   ├── 1Password/              # 1Password configurations
│   └── op/                     # 1Password CLI
├── ansible/                    # Ansible configurations
├── clean_history.zsh           # History cleaning script
└── README.md                   # This documentation
```

## 🛠️ Dependencies

### Required

- **Zsh** - Main shell
- **Git** - Version control
- **Curl** - File downloads

### Automatically Installed

- **Oh My Zsh** - Zsh framework
- **Starship** - Modern prompt
- **eza** - Modern ls replacement
- **bat** - Modern cat replacement
- **fd** - Modern find replacement
- **ripgrep** - Fast text search
- **fzf** - Fuzzy finder

### Optional

- **1Password CLI** - Password management
- **Docker** - Containerisation
- **Ansible** - Configuration automation

## 📦 Manual Installation

If you prefer to install manually or customise the process:

### 1. Clone the Repository

```bash
git clone https://github.com/drsntx/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Install Dependencies

#### macOS (Homebrew)

```bash
# Install Homebrew if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install dependencies
brew install zsh git starship eza bat fd ripgrep fzf
```

#### Ubuntu/Debian

```bash
sudo apt update
sudo apt install zsh git curl build-essential

# Starship
curl -sS https://starship.rs/install.sh | sh

# eza
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo apt update && sudo apt install eza

# Other tools
sudo apt install bat fd-find ripgrep fzf
```

#### Fedora

```bash
sudo dnf install zsh git curl gcc gcc-c++ make
curl -sS https://starship.rs/install.sh | sh
sudo dnf install eza bat fd-find ripgrep fzf
```

#### Arch Linux

```bash
sudo pacman -S zsh git curl base-devel
curl -sS https://starship.rs/install.sh | sh
sudo pacman -S eza bat fd ripgrep fzf
```

### 3. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 4. Install Zsh Plugins

```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
```

### 5. Create Symlinks

```bash
# Backup existing files
[[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.backup

# Create symlinks
ln -sf ~/.dotfiles/dot_zshrc ~/.zshrc
mkdir -p ~/.config/starship
ln -sf ~/.dotfiles/starship/starship.toml ~/.config/starship/starship.toml
```

### 6. Set Zsh as Default Shell

```bash
chsh -s $(which zsh)
```

## ⚙️ Configuration

### Configuration Modules

#### `os_detection.zsh`

Automatically detects the operating system and configures platform-specific paths:

- **macOS**: Homebrew paths (Apple Silicon and Intel)
- **Linux**: Standard paths and distribution-specific settings

#### `aliases.zsh`

Aliases organised by category:

- **Navigation**: `..`, `...`, `~`, `-`
- **Files**: `ll`, `la`, `lt` (with eza)
- **Git**: `g`, `ga`, `gc`, `gp`, `gst`
- **Docker**: `d`, `dc`, `dps`, `di`
- **System**: `reload`, `sysinfo`, `weather`

#### `functions.zsh`

Useful functions for productivity:

- `mkcd()` - Create directory and navigate
- `extract()` - Extract any compressed file
- `backup()` - Create timestamped backup
- `serve()` - Quick HTTP server
- `genpass()` - Generate secure passwords

#### `plugins.zsh`

Optimised plugin configuration:

- **autosuggestions**: History-based suggestions
- **syntax-highlighting**: Real-time syntax highlighting
- **history-substring-search**: Intelligent history search
- **FZF**: Complete integration with preview

### Customisation

#### Local Aliases

Create `~/.aliases.local` for personal aliases:

```bash
# Your custom aliases
alias work='cd ~/Projects/work'
alias personal='cd ~/Projects/personal'
```

#### Local Environment Variables

Create `~/.env.local` for specific variables:

```bash
export CUSTOM_VAR="value"
export API_KEY="your_key_here"
```

#### Local Zsh Configuration

Create `~/.zshrc.local` for specific configurations:

```bash
# Local configurations that shouldn't be versioned
export WORK_PROJECT_PATH="/path/to/work/projects"
```

## 🔐 1Password Configuration

### SSH Agent

1Password can manage your SSH keys automatically:

1. Install 1Password and 1Password CLI
2. Configure SSH agent in 1Password
3. Configurations are already included in dotfiles

### CLI Integration

To use 1Password CLI with secure aliases:

```bash
# Already configured in dotfiles
alias brew="op plugin run -- brew"  # Homebrew with 1Password
```

## 🎨 Starship Customisation

The Starship prompt is configured with:

- **OS Icons**: Shows current operating system
- **Git Information**: Branch, status and modifications
- **Command Duration**: Execution time
- **Python Environments**: Virtualenv and version
- **Docker Integration**: Context when relevant

To customise, edit `~/.dotfiles/starship/starship.toml`.

## 🔄 Maintenance

### Update Dotfiles

```bash
cd ~/.dotfiles
git pull origin main
```

### Update Dependencies

#### macOS

```bash
brew update && brew upgrade
```

#### Ubuntu/Debian

```bash
sudo apt update && sudo apt upgrade
```

#### Fedora

```bash
sudo dnf update
```

#### Arch Linux

```bash
sudo pacman -Syu
```

### Clean History

```bash
# Use the included function
clean_history

# Or run the script directly
~/.dotfiles/clean_history.zsh
```

## 🚨 Troubleshooting

### Zsh is not the Default Shell

```bash
# Check available shells
cat /etc/shells

# Set Zsh as default
chsh -s $(which zsh)
```

### Plugins Don't Load

```bash
# Check if Oh My Zsh is installed
ls -la ~/.oh-my-zsh

# Reinstall plugins
cd ~/.oh-my-zsh/custom/plugins
rm -rf zsh-*
# Run plugin installation again
```

### Starship Doesn't Appear

```bash
# Check if installed
which starship

# Check configuration
echo $STARSHIP_CONFIG

# Reinstall
curl -sS https://starship.rs/install.sh | sh
```

### Modern Tools Don't Work

```bash
# Check installation
which eza bat fd rg fzf

# Reinstall according to your operating system
```

## 🤝 Contributing

This is a personal repository, but suggestions are welcome:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a Pull Request

## 📄 Licence

Personal configuration files - use at your own discretion.

---

**Author**: Daniel Santos  
**Contact**: [GitHub](https://github.com/drsntx)  
**Last Updated**: June 2025
