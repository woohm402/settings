echo "Starting setup..."

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
  curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y
fi

# nvm
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
fi

# bun
if ! command -v bun &> /dev/null; then
  echo "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
fi

# zsh plugins
echo "Installing zsh plugins..."
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi
if [ ! -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Download config files
echo "Downloading configuration files..."
mkdir -p ~/.config/{rio,zed/snippets}
BASE_URL="https://raw.githubusercontent.com/woohm402/settings/main/settings"
curl -fsSL "$BASE_URL/wezterm/wezterm.lua" > ~/.config/wezterm/wezterm.lua
curl -fsSL "$BASE_URL/zed/settings.json" > ~/.config/zed/settings.json
curl -fsSL "$BASE_URL/zed/keymap.json" > ~/.config/zed/keymap.json
curl -fsSL "$BASE_URL/zed/snippets/tsx.json" > ~/.config/zed/snippets/tsx.json
curl -fsSL "$BASE_URL/zsh/.zshrc" > ~/.zshrc

echo "✅ Setup complete! Run 'source ~/.zshrc' to apply changes or restart your terminal."
