# Zsh Plugins Configuration
# Enhanced plugin management with better error handling

# Plugin directory
ZSH_CUSTOM_PLUGINS="$HOME/.oh-my-zsh/custom/plugins"

# Load zsh-autosuggestions
if [[ -f "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
    
    # Configuration for autosuggestions
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
fi

# Load zsh-syntax-highlighting (must be loaded last)
if [[ -f "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    
    # Configuration for syntax highlighting
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
fi

# Load history-substring-search
if [[ -f "$ZSH_CUSTOM_PLUGINS/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
    source "$ZSH_CUSTOM_PLUGINS/zsh-history-substring-search/zsh-history-substring-search.zsh"
    
    # Configuration for history substring search
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white,bold'
    HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'
fi

# FZF integration
if command -v fzf >/dev/null 2>&1; then
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