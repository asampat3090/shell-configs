# VS Code Setup

## Install

### Option A: Download

1. Download VS Code from https://code.visualstudio.com/
2. Open the `.dmg` and drag to Applications

### Option B: Homebrew

```bash
brew install --cask visual-studio-code
```

## CLI Tool

Open VS Code and run the command palette (`Cmd+Shift+P`) > "Shell Command: Install 'code' command in PATH".

Verify:

```bash
code --version
```

## Configuration

VS Code stores settings in `~/Library/Application Support/Code/User/`.

Key files:
- `settings.json` — editor preferences
- `keybindings.json` — custom keyboard shortcuts
- `snippets/` — code snippets

## Settings Sync

VS Code has built-in Settings Sync. After first launch:

1. `Cmd+Shift+P` > "Settings Sync: Turn On"
2. Sign in with GitHub
3. Your settings, extensions, and keybindings will sync automatically

## Recommended Extensions

Install from the command line after setup:

```bash
code --install-extension ms-python.python
code --install-extension esbenp.prettier-vscode
code --install-extension dbaeumer.vscode-eslint
code --install-extension github.copilot
```
