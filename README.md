# Daniel Santos' .dotfiles

Configurações pessoais otimizadas para desenvolvimento multiplataforma (macOS e Linux) com foco em produtividade e automação.

## 🚀 Instalação Rápida

```bash
# Clone o repositório
git clone https://github.com/drsntx/.dotfiles.git ~/.dotfiles

# Execute o script de instalação
cd ~/.dotfiles && ./install.sh
```

O script detecta automaticamente seu sistema operacional e instala todas as dependências necessárias.

## 📋 Funcionalidades

### ✨ Principais Recursos

- **Configuração Modular**: Organizada em módulos lógicos para fácil manutenção
- **Multiplataforma**: Funciona perfeitamente no macOS e Linux
- **Instalação Automática**: Script inteligente que detecta o SO e instala dependências
- **Oh My Zsh Integrado**: Framework completo com plugins essenciais
- **Starship Prompt**: Prompt moderno e rápido com integração Git
- **Ferramentas Modernas**: Substitutos modernos para comandos tradicionais
- **1Password Integration**: Configuração segura para SSH e CLI

### 🔧 Ferramentas Incluídas

| Ferramenta | Substitui | Descrição |
|------------|-----------|-----------|
| `eza` | `ls` | Listagem de arquivos moderna com ícones |
| `bat` | `cat` | Visualizador de arquivos com syntax highlighting |
| `fd` | `find` | Busca de arquivos rápida e intuitiva |
| `ripgrep` | `grep` | Busca em texto ultrarrápida |
| `fzf` | - | Fuzzy finder para histórico e arquivos |
| `starship` | - | Prompt cross-shell personalizável |

## 🏗️ Estrutura do Projeto

```
.dotfiles/
├── install.sh                   # Script de instalação automática
├── dot_zshrc                    # Configuração principal do Zsh
├── zsh/
│   └── zsh.d/                   # Módulos de configuração
│       ├── os_detection.zsh     # Detecção de sistema operacional
│       ├── aliases.zsh          # Aliases personalizados
│       ├── functions.zsh        # Funções úteis
│       ├── history.zsh          # Configuração de histórico
│       ├── paths.zsh            # Gerenciamento de PATH
│       ├── plugins.zsh          # Configuração de plugins
│       └── init.zsh             # Inicialização do shell
├── starship/
│   └── starship.toml           # Configuração do prompt
├── config/
│   ├── 1Password/              # Configurações do 1Password
│   └── op/                     # 1Password CLI
├── ansible/                    # Configurações do Ansible
├── clean_history.zsh           # Script de limpeza de histórico
└── README.md                   # Esta documentação
```

## 🛠️ Dependências

### Obrigatórias

- **Zsh** - Shell principal
- **Git** - Controle de versão
- **Curl** - Download de arquivos

### Instaladas Automaticamente

- **Oh My Zsh** - Framework do Zsh
- **Starship** - Prompt moderno
- **eza** - Substituto moderno do ls
- **bat** - Substituto moderno do cat
- **fd** - Substituto moderno do find
- **ripgrep** - Busca em texto rápida
- **fzf** - Fuzzy finder

### Opcionais

- **1Password CLI** - Gerenciamento de senhas
- **Docker** - Containerização
- **Ansible** - Automação de configuração

## 📦 Instalação Manual

Se preferir instalar manualmente ou personalizar o processo:

### 1. Clone o Repositório

```bash
git clone https://github.com/drsntx/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### 2. Instale as Dependências

#### macOS (Homebrew)

```bash
# Instalar Homebrew se necessário
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar dependências
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

# Outras ferramentas
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

### 3. Instale o Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 4. Instale os Plugins do Zsh

```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.oh-my-zsh/custom/plugins/zsh-history-substring-search
```

### 5. Crie os Symlinks

```bash
# Backup dos arquivos existentes
[[ -f ~/.zshrc ]] && mv ~/.zshrc ~/.zshrc.backup

# Criar symlinks
ln -sf ~/.dotfiles/dot_zshrc ~/.zshrc
mkdir -p ~/.config/starship
ln -sf ~/.dotfiles/starship/starship.toml ~/.config/starship/starship.toml
```

### 6. Configure o Zsh como Shell Padrão

```bash
chsh -s $(which zsh)
```

## ⚙️ Configuração

### Módulos de Configuração

#### `os_detection.zsh`

Detecta automaticamente o sistema operacional e configura paths específicos:

- **macOS**: Homebrew paths (Apple Silicon e Intel)
- **Linux**: Paths padrão e específicos por distribuição

#### `aliases.zsh`

Aliases organizados por categoria:

- **Navegação**: `..`, `...`, `~`, `-`
- **Arquivos**: `ll`, `la`, `lt` (com eza)
- **Git**: `g`, `ga`, `gc`, `gp`, `gst`
- **Docker**: `d`, `dc`, `dps`, `di`
- **Sistema**: `reload`, `sysinfo`, `weather`

#### `functions.zsh`

Funções úteis para produtividade:

- `mkcd()` - Criar diretório e navegar
- `extract()` - Extrair qualquer arquivo compactado
- `backup()` - Criar backup com timestamp
- `serve()` - Servidor HTTP rápido
- `genpass()` - Gerar senhas seguras

#### `plugins.zsh`

Configuração otimizada de plugins:

- **autosuggestions**: Sugestões baseadas no histórico
- **syntax-highlighting**: Destaque de sintaxe em tempo real
- **history-substring-search**: Busca inteligente no histórico
- **FZF**: Integração completa com preview

### Personalização

#### Aliases Locais

Crie `~/.aliases.local` para aliases pessoais:

```bash
# Seus aliases personalizados
alias work='cd ~/Projects/work'
alias personal='cd ~/Projects/personal'
```

#### Variáveis de Ambiente Locais

Crie `~/.env.local` para variáveis específicas:

```bash
export CUSTOM_VAR="valor"
export API_KEY="sua_chave_aqui"
```

#### Configuração Local do Zsh

Crie `~/.zshrc.local` para configurações específicas:

```bash
# Configurações locais que não devem ser versionadas
export WORK_PROJECT_PATH="/path/to/work/projects"
```

## 🔐 Configuração do 1Password

### SSH Agent

O 1Password pode gerenciar suas chaves SSH automaticamente:

1. Instale o 1Password e o 1Password CLI
2. Configure o SSH agent no 1Password
3. As configurações já estão incluídas nos dotfiles

### CLI Integration

Para usar o 1Password CLI com aliases seguros:

```bash
# Já configurado nos dotfiles
alias brew="op plugin run -- brew"  # Homebrew com 1Password
```

## 🎨 Personalização do Starship

O prompt Starship está configurado com:

- **Ícones do OS**: Mostra o sistema operacional atual
- **Informações Git**: Branch, status e modificações
- **Duração de Comandos**: Tempo de execução
- **Ambientes Python**: Virtualenv e versão
- **Integração Docker**: Contexto quando relevante

Para personalizar, edite `~/.dotfiles/starship/starship.toml`.

## 🔄 Manutenção

### Atualizar Dotfiles

```bash
cd ~/.dotfiles
git pull origin main
```

### Atualizar Dependências

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

### Limpar Histórico

```bash
# Usar a função incluída
clean_history

# Ou executar o script diretamente
~/.dotfiles/clean_history.zsh
```

## 🚨 Solução de Problemas

### Zsh não é o Shell Padrão

```bash
# Verificar shells disponíveis
cat /etc/shells

# Definir Zsh como padrão
chsh -s $(which zsh)
```

### Plugins não Carregam

```bash
# Verificar se Oh My Zsh está instalado
ls -la ~/.oh-my-zsh

# Reinstalar plugins
cd ~/.oh-my-zsh/custom/plugins
rm -rf zsh-*
# Execute novamente a instalação dos plugins
```

### Starship não Aparece

```bash
# Verificar se está instalado
which starship

# Verificar configuração
echo $STARSHIP_CONFIG

# Reinstalar
curl -sS https://starship.rs/install.sh | sh
```

### Ferramentas Modernas não Funcionam

```bash
# Verificar instalação
which eza bat fd rg fzf

# Reinstalar conforme seu sistema operacional
```

## 🤝 Contribuição

Este é um repositório pessoal, mas sugestões são bem-vindas:

1. Fork o repositório
2. Crie uma branch para sua feature
3. Faça commit das mudanças
4. Abra um Pull Request

## 📄 Licença

Configurações pessoais - use por sua conta e risco.

---

**Autor**: Daniel Santos  
**Contato**: [GitHub](https://github.com/drsntx)  
**Última Atualização**: Dezembro 2024
