# Cursor IDE Setup

## Install

1. Download Cursor from https://www.cursor.com/
2. Open the `.dmg` and drag to Applications
3. Launch Cursor and sign in

## CLI Tool

Cursor installs its CLI automatically. Verify with:

```bash
cursor --version
```

If not available, open Cursor and run the command palette (`Cmd+Shift+P`) > "Install 'cursor' command".

## Configuration

Cursor stores config in two locations:

- **`~/.cursor/`** — dot-cursor home directory (argv, gitignore)
- **`~/Library/Application Support/Cursor/User/`** — editor settings & keybindings

The setup script symlinks config from this repo into both locations.

### Files stored in this repo

| File | Symlinked to | Purpose |
|------|-------------|---------|
| `settings.json` | `~/Library/Application Support/Cursor/User/settings.json` | Editor, formatter, theme settings |
| `keybindings.json` | `~/Library/Application Support/Cursor/User/keybindings.json` | Custom keyboard shortcuts |
| `argv.json` | `~/.cursor/argv.json` | Startup arguments (crash reporter, hardware accel) |
| `dot-cursor-gitignore` | `~/.cursor/.gitignore` | Controls what Cursor tracks in ~/.cursor |

## Extensions

Extensions sync through Cursor's built-in sync. After first launch, sign in
and your extensions will restore automatically.

## Key Settings

- Rules: `~/.cursor/rules/` — global Cursor rules applied to all projects
- Skills: `~/.cursor/skills-cursor/` — built-in Cursor skills
- MCP: `~/.cursor/mcp.json` — Model Context Protocol tool config
