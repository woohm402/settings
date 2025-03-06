echo "Starting"
curl https://raw.githubusercontent.com/woohm402/settings/refs/heads/main/settings/rio/config.toml > ~/.config/rio/config.toml
curl https://raw.githubusercontent.com/woohm402/settings/refs/heads/main/settings/zed/settings.json > ~/.config/zed/settings.json
curl https://raw.githubusercontent.com/woohm402/settings/refs/heads/main/settings/zed/keymap.json > ~/.config/zed/keymap.json
curl https://raw.githubusercontent.com/woohm402/settings/refs/heads/main/settings/zed/snippets/tsx.json > ~/.config/zed/snippets/tsx.json
curl https://raw.githubusercontent.com/woohm402/settings/refs/heads/main/settings/zsh/.zshrc > ~/.zshrc
echo "Done"
