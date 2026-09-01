# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository that serves as a Single Source of Truth (SSOT) for development environment configuration. It contains configuration files for various development tools and an automated setup script that can be deployed via `curl -L https://settings.woohm404.com/init.sh | bash`.

## Repository Structure

```
settings/
├── homebrew/      # Brewfile - CLI tools, GUI apps, fonts
│   └── Brewfile
├── rectangle/     # Rectangle window manager configuration
│   └── RectangleConfig.json
├── zed/           # Zed editor configuration
│   ├── settings.json
│   ├── keymap.json
│   └── snippets/
│       └── tsx.json
└── zsh/           # Zsh shell configuration
    └── .zshrc
scripts/
├── init.sh        # Setup script that installs tools and downloads configs
└── macos.sh       # macOS system preferences (defaults write)
```

## Key Behaviors

### Git Workflow
- Branch naming convention: `woohm402/YYYYMMDDHHMMSS` (generated via `gswr` function in .zshrc)
- PRs are created against the `main` branch
- The `ghpr` function opens a browser to create a PR for the current branch

### Setup Script (`scripts/init.sh`)
The init script is **idempotent** and **fail-safe**. When modifying:
- Always preserve the idempotent behavior (check before install)
- Always download config files through the `download()` helper — it writes to a temp
  file and only replaces the destination on success, backing up the previous version
  to `.bak`. Never use `curl ... > ~/.file`: the redirect truncates the target before
  curl runs, so a network failure destroys the existing config.
- Keep `set -euo pipefail` at the top; report download failures via `FAILURES` and
  exit non-zero at the end rather than dying mid-way
- Homebrew must be installed first — brew packages and `brew shellenv` depend on it
- Directly installed (not via brew): Oh My Zsh, Google Cloud SDK, Rust, NVM, Bun, uv, cargo-binstall
- Installed via `brew bundle`: see `settings/homebrew/Brewfile`
- Installed zsh plugins: zsh-autosuggestions, zsh-syntax-highlighting, zsh-hangul

### Configuration File Paths
When updating the init script, ensure config files are downloaded to:
- Zed: `~/.config/zed/`
- Zsh: `~/.zshrc`
- Rectangle: `~/Library/Application Support/Rectangle/` (loaded on launch, file is renamed after loading — the script quits and relaunches Rectangle if it was running)

### Program Inventory
The tool set is declared in two places and they must stay in sync:
- `settings/homebrew/Brewfile` — what gets installed
- `README.md` — the human-readable list, including manually installed programs

Programs that are no longer used should be removed from the Brewfile, the README, and
their config directory under `settings/` in the same change.

### Terminal
No dedicated terminal emulator is configured. The Zed built-in terminal and the stock
macOS Terminal.app are used as-is; Terminal.app has no customized preference domain,
so there is nothing to track for it.

### Zed Editor Configuration
- Uses TypeScript language servers: `tsgo` and `vtsls`
- Biome requires config file (`require_config_file: true`)
- Import preferences: non-relative imports for TypeScript
- Code actions on format: ESLint auto-fix enabled
- Font: Monaspace Krypton (installed via the `font-monaspace` cask)

### macOS Defaults (`scripts/macos.sh`)
Only settings that are actually deviated from macOS defaults belong here. Do not add
`defaults write` calls for values that are already the system default — read the current
value with `defaults read` before adding anything.

## Maintenance Notes

- New brew-installable tools go in the Brewfile, not in `init.sh`
- Non-brew installers in `init.sh` follow the existing pattern of checking if the tool exists first
- When adding a new config file, update both the `settings/` directory and the download section in `init.sh`
