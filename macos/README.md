# macOS Setup (Optional)

These are optional setup steps for a fresh macOS installation.
Run `setup-macos.sh` only if you want these defaults applied.

## What It Does

1. **Homebrew** — installs Homebrew if not present, then installs common formulae and casks
2. **macOS Defaults** — sets sensible Finder, Dock, and keyboard preferences
3. **Fonts** — installs developer fonts via Homebrew cask

## Usage

```bash
cd macos
./setup-macos.sh
```

This script is idempotent and safe to re-run.
