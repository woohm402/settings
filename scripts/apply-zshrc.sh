#!/bin/sh

CURRENT_SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)"
SETTINGS_TARGET_PATH="$CURRENT_SCRIPT_PATH/../settings"

cp "$SETTINGS_TARGET_PATH/.zshrc" ~/.zshrc
