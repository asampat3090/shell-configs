# Dev Environment Setup

Bootstrap a new Mac with my terminal, IDE, and AI tool configs.

## Quick Start

```bash
git clone https://github.com/asampat3090/shellConfigs.git ~/code/shell-configs
cd ~/code/shell-configs
chmod +x setup.sh
./setup.sh
```

## What `setup.sh` Does

1. **Terminal** — symlinks `.zshrc`, `.vimrc`, `.vim/`, `.gitconfig`, `.gitignore_global`
2. **Oh My Zsh** — installs if not present
3. **Homebrew** — installs if not present, then installs core formulae (`git`, `node`, `nvm`, `python3`, `vim`)
4. **Vim** — installs Vundle and plugins
5. **Cursor** — checks if installed (manual download from cursor.com)
6. **VS Code** — installs via Homebrew cask if not present
7. **Claude Code** — installs via npm if not present
8. **Claude Code config** — symlinks `settings.json` and global `CLAUDE.md`

Existing files are backed up to `~/.dotfiles-backup/<timestamp>/` before being replaced.

The script is **idempotent** — safe to run multiple times.

## Repo Structure

```
shell-configs/
├── setup.sh                # Main bootstrap script
├── terminal/
│   ├── .zshrc              # Zsh config (oh-my-zsh)
│   ├── .vimrc              # Vim config
│   ├── .vim/               # Vim plugins/runtime
│   ├── .gitconfig          # Git identity & settings
│   └── .gitignore_global   # Global gitignore
├── ide/
│   ├── cursor/
│   │   └── README.md       # Cursor install & setup guide
│   └── vscode/
│       └── README.md       # VS Code install & setup guide
├── ai/
│   ├── README.md           # Claude Code install & setup guide
│   └── .claude/
│       ├── settings.json   # Default model preferences
│       └── CLAUDE.md       # Global instructions for Claude
├── macos/
│   ├── README.md           # Optional macOS setup guide
│   └── setup-macos.sh      # Extra tools & macOS defaults
└── legacy/
    └── vimrc.txt           # Old vim config (archived)
```

## Optional: macOS Defaults & Extra Tools

```bash
chmod +x macos/setup-macos.sh
./macos/setup-macos.sh
```

Installs extra tools (`jq`, `ripgrep`, `fzf`, `gh`, `tmux`, etc.), cask apps
(`iTerm2`, `Rectangle`, `Docker`), developer fonts, and sets sensible macOS
Finder/Dock/keyboard defaults.
