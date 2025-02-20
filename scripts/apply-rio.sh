#!/bin/sh

CURRENT_SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)"
SETTINGS_TARGET_PATH="$CURRENT_SCRIPT_PATH/../settings"

cp "$SETTINGS_TARGET_PATH/zed/keymap.json" ~/.config/zed/keymap.json
cp "$SETTINGS_TARGET_PATH/zed/settings.json" ~/.config/zed/settings.json
