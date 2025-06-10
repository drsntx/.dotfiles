# Zsh Plugins Configuration
# Enhanced plugin management with better error handling

# Plugin directory
ZSH_CUSTOM_PLUGINS="$HOME/.oh-my-zsh/custom/plugins"

# Function to safely source plugins
load_plugin() {
    local plugin_name="$1"
    local plugin_file="$2"
    
    if [[ -f "$plugin_file" ]]; then
        source "$plugin_file"
        echo "✓ Loaded plugin: $plugin_name"
    else
        echo "⚠ Plugin not found: $plugin_name ($plugin_file)"
    fi
}

# Load zsh-autosuggestions
if [[ -d "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions" ]]; then
    source "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
    
    # Configuration for autosuggestions
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# Load zsh-syntax-highlighting (must be loaded last)
if [[ -d "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" ]]; then
    source "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    
    # Configuration for syntax highlighting
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
    ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=white,bold,bg=red')
fi

# Load history-substring-search
if [[ -d "$ZSH_CUSTOM_PLUGINS/zsh-history-substring-search" ]]; then
    source "$ZSH_CUSTOM_PLUGINS/zsh-history-substring-search/zsh-history-substring-search.zsh"
    
    # Configuration for history substring search
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white,bold'
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
    HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'
fi

# FZF integration
if command -v fzf >/dev/null 2>&1; then
    # Set FZF default options
    export FZF_DEFAULT_OPTS="
        --height 40% 
        --layout=reverse 
        --border 
        --preview 'bat --style=numbers --color=always --line-range :500 {}'
        --preview-window=right:50%:wrap
    "
    
    # Use fd instead of find if available
    if command -v fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    fi
    
    # FZF key bindings and completion
    case "$DOTFILES_OS" in
        "macos")
            if [[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]]; then
                source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
            fi
            if [[ -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]]; then
                source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
            fi
            ;;
        "linux")
            if [[ -f "/usr/share/fzf/key-bindings.zsh" ]]; then
                source "/usr/share/fzf/key-bindings.zsh"
            fi
            if [[ -f "/usr/share/fzf/completion.zsh" ]]; then
                source "/usr/share/fzf/completion.zsh"
            fi
            ;;
    esac
fi

