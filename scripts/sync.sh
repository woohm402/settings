#!/bin/sh

MODE=$1
TARGET=$2

CURRENT_SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)"
SETTINGS_TARGET_PATH="$CURRENT_SCRIPT_PATH/../settings"

if [ $TARGET = "zshrc" ] && [ $MODE = "save"  ]; then
    cp ~/.zshrc "$SETTINGS_TARGET_PATH/.zshrc";
    exit 0;
elif [ $TARGET = "zshrc" ] && [ $MODE = "load" ]; then
    cp "$SETTINGS_TARGET_PATH/.zshrc" ~/.zshrc;
    exit 0;
else
    echo "No Match: $TARGET";
    exit 1;
fi;

