#!/bin/bash
echo "Starting setup..."

# homebrew
if ! command -v brew &> /dev/null && [ ! -x /opt/homebrew/bin/brew ]; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed, skipping..."
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

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
if [ ! -s "$HOME/.nvm/nvm.sh" ]; then
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

# uv
if ! command -v uv &> /dev/null; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  echo "uv already installed, skipping..."
fi

# gh
if ! command -v gh &> /dev/null; then
  echo "Installing GitHub CLI..."
  brew install gh
else
  echo "GitHub CLI already installed, skipping..."
fi

# claude code
if ! command -v claude &> /dev/null; then
  echo "Installing Claude Code..."
  curl -fsSL https://claude.ai/install.sh | bash
else
  echo "Claude Code already installed, skipping..."
fi

# codex
if ! command -v codex &> /dev/null; then
  echo "Installing Codex CLI..."
  brew install --cask codex
else
  echo "Codex CLI already installed, skipping..."
fi

# zed
if [ ! -d "/Applications/Zed.app" ]; then
  echo "Installing Zed..."
  brew install --cask zed
else
  echo "Zed already installed, skipping..."
fi

# orca
if [ ! -d "/Applications/Orca.app" ]; then
  echo "Installing Orca..."
  brew install --cask stablyai/orca/orca
else
  echo "Orca already installed, skipping..."
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

# Check if zsh-hangul is already installed
if [ ! -d "$ZSH_PLUGIN_DIR/zsh-hangul" ]; then
  echo "Installing zsh-hangul..."
  git clone https://github.com/gomjellie/zsh-hangul.git "$ZSH_PLUGIN_DIR/zsh-hangul"
else
  echo "zsh-hangul already installed, skipping..."
fi

# Download config files
echo "Downloading configuration files..."
BASE_URL="https://raw.githubusercontent.com/woohm402/settings/main/settings"

# Create directories if they don't exist
mkdir -p ~/.config/zed/snippets

# Download and update config files
echo "Updating zed configs..."
curl -fsSL "$BASE_URL/zed/settings.json" > ~/.config/zed/settings.json
curl -fsSL "$BASE_URL/zed/keymap.json" > ~/.config/zed/keymap.json
curl -fsSL "$BASE_URL/zed/snippets/tsx.json" > ~/.config/zed/snippets/tsx.json

echo "Updating zshrc..."
curl -fsSL "$BASE_URL/zsh/.zshrc" > ~/.zshrc

echo "Updating rectangle config..."
mkdir -p ~/Library/Application\ Support/Rectangle
curl -fsSL "$BASE_URL/rectangle/RectangleConfig.json" > ~/Library/Application\ Support/Rectangle/RectangleConfig.json

echo "✅ Setup complete! Run 'source ~/.zshrc' to apply changes or restart your terminal."
