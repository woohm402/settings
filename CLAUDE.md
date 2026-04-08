# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository that serves as a Single Source of Truth (SSOT) for development environment configuration. It contains configuration files for various development tools and an automated setup script that can be deployed via `curl -L https://settings.woohm404.com/init.sh | bash`.

## Repository Structure

```
settings/
├── cmux/          # cmux terminal multiplexer configuration (Ghostty config format)
│   └── config.ghostty
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
└── init.sh        # Setup script that installs tools and downloads configs
```

## Key Behaviors

### Git Workflow
- Branch naming convention: `woohm402/YYYYMMDDHHMMSS` (generated via `gswr` function in .zshrc)
- PRs are created against the `main` branch
- The `ghpr` function opens a browser to create a PR for the current branch

### Setup Script (`scripts/init.sh`)
The init script is designed to be **idempotent** - it checks if tools are already installed before attempting installation. When modifying:
- Always preserve this idempotent behavior (check before install)
- Downloads config files from `https://raw.githubusercontent.com/woohm402/settings/main/settings/`
- Creates necessary directories before downloading configs
- Installed tools: Oh My Zsh, Google Cloud SDK, Rust, NVM, Bun, uv, cargo-binstall, zellij
- Installed zsh plugins: zsh-autosuggestions, zsh-syntax-highlighting, zsh-hangul

### Configuration File Paths
When updating the init script, ensure config files are downloaded to:
- cmux: `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`
- Rectangle: `~/Library/Application Support/Rectangle/` (auto-loaded on launch, file is renamed after loading)
- Zed: `~/.config/zed/`
- Zsh: `~/.zshrc`

### cmux Configuration
- Uses Ghostty config format (`config.ghostty`)
- Font: Monaspace Krypton (matching Zed), Korean fallback: Sarasa Term K
- Font style: Bold

### Zed Editor Configuration
- Uses TypeScript language servers: `tsgo` and `vtsls`
- Biome requires config file (`require_config_file: true`)
- Import preferences: non-relative imports for TypeScript
- Code actions on format: ESLint auto-fix enabled
- Font: Monaspace Krypton

## Maintenance Notes

- When adding new tool installations to `init.sh`, follow the existing pattern of checking if the tool exists first
- When adding new config files, update both the `settings/` directory and the download section in `init.sh`
