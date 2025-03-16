echo "Starting setup..."

# Create directories first
mkdir -p ~/.config/{rio,zed/snippets}

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# gcloud
if ! command -v gcloud &> /dev/null; then
  echo "Installing Google Cloud SDK..."
  export CLOUDSDK_CORE_DISABLE_PROMPTS=1
  curl https://sdk.cloud.google.com | bash
fi

# rust
if ! command -v rustup &> /dev/null; then
  echo "Installing Rust..."
  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
fi

# Install zsh plugins
echo "Installing zsh plugins..."
# zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Install Bun
if ! command -v bun &> /dev/null; then
  echo "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
fi

# Download config files
BASE_URL="https://raw.githubusercontent.com/woohm402/settings/main/settings"
echo "Downloading configuration files..."
curl -fsSL "$BASE_URL/rio/config.toml" > ~/.config/rio/config.toml
curl -fsSL "$BASE_URL/zed/settings.json" > ~/.config/zed/settings.json
curl -fsSL "$BASE_URL/zed/keymap.json" > ~/.config/zed/keymap.json
curl -fsSL "$BASE_URL/zed/snippets/tsx.json" > ~/.config/zed/snippets/tsx.json
curl -fsSL "$BASE_URL/zsh/.zshrc" > ~/.zshrc

echo "✅ Setup complete! Please restart your terminal."
echo "NOTE: You may need to manually install Monaspace fonts."
