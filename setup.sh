#!/usr/bin/env bash
#
# setup.sh — Bootstrap development environment on a new Mac.
#
# This script is idempotent: safe to run multiple times.
# It symlinks config files and installs core tools.
# It will NOT overwrite existing files — it backs them up first.
#
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

# --- Helpers ---

log()  { printf '\033[1;34m==> %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33mWARN: %s\033[0m\n' "$*"; }
ok()   { printf '\033[1;32m OK: %s\033[0m\n' "$*"; }
err()  { printf '\033[1;31mERR: %s\033[0m\n' "$*" >&2; }

backup_and_link() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        err "Source does not exist: $src"
        return 1
    fi

    # Already correctly linked
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        ok "$dest -> $src (already linked)"
        return 0
    fi

    # Back up existing file/dir if it exists and isn't a broken symlink
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        mkdir -p "$BACKUP_DIR"
        warn "Backing up $dest -> $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    fi

    # Ensure parent directory exists
    mkdir -p "$(dirname "$dest")"

    ln -s "$src" "$dest"
    ok "$dest -> $src"
}

command_exists() {
    command -v "$1" &>/dev/null
}

# --- 1. Terminal ---

log "Setting up terminal configs..."

backup_and_link "$REPO_DIR/terminal/.zshrc"           "$HOME/.zshrc"
backup_and_link "$REPO_DIR/terminal/.vimrc"            "$HOME/.vimrc"
backup_and_link "$REPO_DIR/terminal/.vim"              "$HOME/.vim"
backup_and_link "$REPO_DIR/terminal/.gitconfig"        "$HOME/.gitconfig"
backup_and_link "$REPO_DIR/terminal/.gitignore_global" "$HOME/.gitignore_global"

# --- 2. Oh My Zsh ---

log "Checking Oh My Zsh..."

if [ -d "$HOME/.oh-my-zsh" ]; then
    ok "Oh My Zsh already installed"
else
    log "Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes \
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || {
            err "Oh My Zsh installation failed"
        }
fi

# --- 3. Homebrew ---

log "Checking Homebrew..."

if command_exists brew; then
    ok "Homebrew already installed"
else
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
        err "Homebrew installation failed"
    }
    # Add brew to PATH for the rest of this script (Apple Silicon path)
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
fi

# --- 4. Core tools via Homebrew ---

log "Installing core tools..."

BREW_FORMULAE=(
    git
    git-lfs
    node
    nvm
    python3
    vim
)

for formula in "${BREW_FORMULAE[@]}"; do
    if brew list "$formula" &>/dev/null; then
        ok "$formula already installed"
    else
        log "Installing $formula..."
        brew install "$formula" || warn "Failed to install $formula (continuing)"
    fi
done

# --- 5. NVM setup ---

log "Setting up NVM..."

export NVM_DIR="$HOME/.nvm"
mkdir -p "$NVM_DIR"

# Source nvm if available (Homebrew installs it here)
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
    source "/opt/homebrew/opt/nvm/nvm.sh"
elif [ -s "$NVM_DIR/nvm.sh" ]; then
    source "$NVM_DIR/nvm.sh"
fi

if command_exists nvm; then
    ok "NVM available"
    # Install latest LTS if no Node versions installed
    if ! nvm ls --no-colors 2>/dev/null | grep -q 'v[0-9]'; then
        log "Installing Node.js LTS..."
        nvm install --lts || warn "Failed to install Node.js LTS"
    else
        ok "Node.js already installed via NVM"
    fi
else
    warn "NVM not available — skipping Node.js setup"
fi

# --- 6. Vim plugins ---

log "Setting up Vim plugins..."

VUNDLE_DIR="$HOME/.vim/bundle/Vundle.vim"
if [ -d "$VUNDLE_DIR" ]; then
    ok "Vundle already installed"
else
    log "Installing Vundle..."
    git clone https://github.com/VundleVim/Vundle.vim.git "$VUNDLE_DIR" || {
        warn "Failed to clone Vundle"
    }
fi

# Install Vim plugins non-interactively
if [ -d "$VUNDLE_DIR" ]; then
    log "Installing Vim plugins..."
    vim +PluginInstall +qall 2>/dev/null || warn "Vim plugin install had issues (non-critical)"
    ok "Vim plugins done"
fi

# --- 7. IDE: Cursor ---

log "Checking Cursor..."

if [ -d "/Applications/Cursor.app" ]; then
    ok "Cursor already installed"
else
    log "Install Cursor manually from https://www.cursor.com/"
    warn "Cursor must be downloaded from cursor.com (no Homebrew cask available)"
fi

log "Setting up Cursor config..."

CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"
mkdir -p "$CURSOR_USER_DIR"

backup_and_link "$REPO_DIR/ide/cursor/settings.json"          "$CURSOR_USER_DIR/settings.json"
backup_and_link "$REPO_DIR/ide/cursor/keybindings.json"       "$CURSOR_USER_DIR/keybindings.json"
backup_and_link "$REPO_DIR/ide/cursor/argv.json"              "$HOME/.cursor/argv.json"
backup_and_link "$REPO_DIR/ide/cursor/dot-cursor-gitignore"   "$HOME/.cursor/.gitignore"

# --- 8. IDE: VS Code ---

log "Checking VS Code..."

if [ -d "/Applications/Visual Studio Code.app" ] || command_exists code; then
    ok "VS Code already installed"
else
    log "Installing VS Code via Homebrew..."
    brew install --cask visual-studio-code || warn "Failed to install VS Code"
fi

# --- 9. Claude Code ---

log "Checking Claude Code..."

if command_exists claude; then
    ok "Claude Code already installed"
else
    log "Installing Claude Code..."
    if command_exists npm; then
        npm install -g @anthropic-ai/claude-code || warn "Failed to install Claude Code"
    else
        warn "npm not available — install Node.js first, then run: npm install -g @anthropic-ai/claude-code"
    fi
fi

# --- 10. Claude Code config ---

log "Setting up Claude Code config..."

mkdir -p "$HOME/.claude"

backup_and_link "$REPO_DIR/ai/.claude/settings.json" "$HOME/.claude/settings.json"
backup_and_link "$REPO_DIR/ai/.claude/CLAUDE.md"     "$HOME/.claude/CLAUDE.md"

# --- Done ---

echo ""
log "Setup complete!"
echo ""
echo "  Next steps:"
echo "    1. Open a new terminal to pick up .zshrc changes"
echo "    2. Launch Cursor and/or VS Code and sign in"
echo "    3. Run 'claude' to authenticate Claude Code"
echo ""
if [ -d "$BACKUP_DIR" ]; then
    echo "  Backed-up files are in: $BACKUP_DIR"
    echo ""
fi
echo "  Optional: run macos/setup-macos.sh for macOS defaults & extra tools"
echo ""
