# Salve este script como ~/.dotfiles/zsh/clean_history.zsh e execute-o
#!/bin/zsh
cp "$ZDOTDIR/.zsh_history" "$ZDOTDIR/.zsh_history.bak"
sed 's/^: [0-9]*:[0-9]*;//' "$ZDOTDIR/.zsh_history.bak" > "$ZDOTDIR/.zsh_history.clean"
mv "$ZDOTDIR/.zsh_history.clean" "$ZDOTDIR/.zsh_history"
echo "Histórico limpo e salvo em $ZDOTDIR/.zsh_history"

