#!/usr/bin/env bash
#
# export-settings.sh — Export iTerm2 preferences into this repo.
#
# Run this on the laptop that has your iTerm2 configured the way you like.
# After running, commit the generated plist file to the repo.
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_SRC="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
PLIST_DEST="$SCRIPT_DIR/com.googlecode.iterm2.plist"

log()  { printf '\033[1;34m==> %s\033[0m\n' "$*"; }
ok()   { printf '\033[1;32m OK: %s\033[0m\n' "$*"; }
err()  { printf '\033[1;31mERR: %s\033[0m\n' "$*" >&2; }

if [ ! -f "$PLIST_SRC" ]; then
    err "iTerm2 preferences not found at $PLIST_SRC"
    err "Make sure iTerm2 has been launched at least once."
    exit 1
fi

log "Exporting iTerm2 preferences..."

# Convert binary plist to XML so it's readable and diffs well in git
plutil -convert xml1 -o "$PLIST_DEST" "$PLIST_SRC"

ok "Exported to $PLIST_DEST"
echo ""
echo "  Next steps:"
echo "    1. Review the exported file (it may contain host-specific paths)"
echo "    2. git add terminal/iterm2/com.googlecode.iterm2.plist"
echo "    3. git commit -m 'Add iTerm2 settings'"
echo "    4. git push"
echo ""
