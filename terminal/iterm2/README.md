# iTerm2 Settings

Store and restore iTerm2 preferences across machines.

## Export (on the laptop with your settings)

```bash
cd ~/code/dev-setup
chmod +x terminal/iterm2/export-settings.sh
./terminal/iterm2/export-settings.sh
```

This copies `~/Library/Preferences/com.googlecode.iterm2.plist` into this
directory as XML (so it diffs cleanly in git). Commit and push the result.

## Import (on a new laptop)

The main `setup-macos.sh` script handles this automatically — it tells iTerm2
to load preferences from this repo folder. If you want to do it manually:

```bash
# Point iTerm2 at the repo's settings folder
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/code/dev-setup/terminal/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
```

Then relaunch iTerm2. It will pick up the stored preferences.

## How it works

iTerm2 has a built-in feature under **Settings > General > Preferences** called
"Load preferences from a custom folder or URL". The setup script configures
this programmatically via `defaults write`, pointing it at the repo directory.

On subsequent launches iTerm2 reads `com.googlecode.iterm2.plist` from that
folder instead of the default `~/Library/Preferences/` location.

## Re-exporting after changes

Any time you tweak your iTerm2 settings and want to save them, re-run:

```bash
./terminal/iterm2/export-settings.sh
```

Then commit the updated plist.
