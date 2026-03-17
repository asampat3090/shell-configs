# AI Tools Setup

## Claude Code

### Install

```bash
npm install -g @anthropic-ai/claude-code
```

Requires Node.js 18+. If you don't have Node.js, the terminal setup script
installs nvm which you can use:

```bash
nvm install 18
nvm use 18
```

### Verify

```bash
claude --version
```

### Configuration

The setup script symlinks the following to `~/.claude/`:

- `settings.json` — default model preferences
- `CLAUDE.md` — global instructions applied to all conversations

### First Run

1. Run `claude` in any directory
2. Authenticate with your Anthropic API key when prompted
3. Your global `CLAUDE.md` instructions will apply automatically

### Per-Project Instructions

Add a `CLAUDE.md` file to any project root for project-specific instructions.
These are merged with the global instructions.
