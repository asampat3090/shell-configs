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

Cursor stores its config in `~/.cursor/`. The setup script symlinks relevant
config from this repo.

## Extensions

Extensions sync through Cursor's built-in sync. After first launch, sign in
and your extensions will restore automatically.

## Key Settings

- Rules: `~/.cursor/rules/` — global Cursor rules applied to all projects
- Skills: `~/.cursor/skills-cursor/` — built-in Cursor skills
- MCP: `~/.cursor/mcp.json` — Model Context Protocol tool config
