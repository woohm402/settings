#!/bin/bash
echo "Starting setup..."

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "Oh My Zsh already installed, skipping..."
fi

# gcloud
if ! command -v gcloud &> /dev/null; then
  echo "Installing Google Cloud SDK..."
  export CLOUDSDK_CORE_DISABLE_PROMPTS=1
  curl https://sdk.cloud.google.com | bash
else
  echo "Google Cloud SDK already installed, skipping..."
fi

# rust
if ! command -v rustup &> /dev/null; then
  echo "Installing Rust..."
  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y
else
  echo "Rust already installed, skipping..."
fi

# nvm
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
else
  echo "NVM already installed, skipping..."
fi

# bun
if ! command -v bun &> /dev/null; then
  echo "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
else
  echo "Bun already installed, skipping..."
fi

# zsh plugins
echo "Setting up zsh plugins..."
ZSH_PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

# Check if zsh-autosuggestions is already installed
if [ ! -d "$ZSH_PLUGIN_DIR/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGIN_DIR/zsh-autosuggestions"
else
  echo "zsh-autosuggestions already installed, skipping..."
fi

# Check if zsh-syntax-highlighting is already installed
if [ ! -d "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting" ]; then
  echo "Installing zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGIN_DIR/zsh-syntax-highlighting"
else
  echo "zsh-syntax-highlighting already installed, skipping..."
fi

# Download config files
echo "Downloading configuration files..."
BASE_URL="https://raw.githubusercontent.com/woohm402/settings/main/settings"

# Create directories if they don't exist
mkdir -p ~/.config/rio
mkdir -p ~/.config/zed/snippets
mkdir -p ~/.config/wezterm

# Download and update config files
echo "Updating wezterm config..."
curl -fsSL "$BASE_URL/wezterm/wezterm.lua" > ~/.config/wezterm/wezterm.lua

echo "Updating zed configs..."
curl -fsSL "$BASE_URL/zed/settings.json" > ~/.config/zed/settings.json
curl -fsSL "$BASE_URL/zed/keymap.json" > ~/.config/zed/keymap.json
curl -fsSL "$BASE_URL/zed/snippets/tsx.json" > ~/.config/zed/snippets/tsx.json

echo "Updating zshrc..."
curl -fsSL "$BASE_URL/zsh/.zshrc" > ~/.zshrc

echo "✅ Setup complete! Run 'source ~/.zshrc' to apply changes or restart your terminal."
