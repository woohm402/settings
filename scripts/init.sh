echo "Starting"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

curl -fsSL https://bun.sh/install | bash

mkdir -p ~/.config/rio
mkdir -p ~/.config/zed
mkdir -p ~/.config/zed/snippets
curl https://raw.githubusercontent.com/woohm402/settings/refs/heads/main/settings/rio/config.toml > ~/.config/rio/config.toml
curl https://raw.githubusercontent.com/woohm402/settings/refs/heads/main/settings/zed/settings.json > ~/.config/zed/settings.json
curl https://raw.githubusercontent.com/woohm402/settings/refs/heads/main/settings/zed/keymap.json > ~/.config/zed/keymap.json
curl https://raw.githubusercontent.com/woohm402/settings/refs/heads/main/settings/zed/snippets/tsx.json > ~/.config/zed/snippets/tsx.json
curl https://raw.githubusercontent.com/woohm402/settings/refs/heads/main/settings/zsh/.zshrc > ~/.zshrc

echo "Done"
