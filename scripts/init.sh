#!/bin/bash
set -euo pipefail

REPO_BASE="https://raw.githubusercontent.com/woohm402/settings/main"
BASE_URL="$REPO_BASE/settings"
FAILURES=0

# 설정 파일을 임시 파일로 받은 뒤 성공했을 때만 교체한다.
# 리다이렉션(`curl > file`)은 curl 실패 시 대상 파일을 비워버리므로 쓰지 않는다.
download() {
  local url="$1" dest="$2" tmp
  tmp="$(mktemp)"
  if ! curl -fsSL "$url" -o "$tmp"; then
    echo "  ⚠️  download failed: $url (keeping existing $dest)"
    rm -f "$tmp"
    FAILURES=$((FAILURES + 1))
    return 0
  fi
  if [ -f "$dest" ] && cmp -s "$tmp" "$dest"; then
    echo "  unchanged: $dest"
    rm -f "$tmp"
    return 0
  fi
  if [ -f "$dest" ]; then
    cp "$dest" "$dest.bak"
    echo "  backed up: $dest -> $dest.bak"
  fi
  mkdir -p "$(dirname "$dest")"
  mv "$tmp" "$dest"
  chmod 644 "$dest"
  echo "  updated: $dest"
  return 0
}

echo "Starting setup..."

# homebrew — 다른 설치들이 여기에 의존하므로 가장 먼저
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew already installed, skipping..."
fi

# 이 스크립트 세션에서도 brew를 쓸 수 있게 PATH 설정
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

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

# uv
if ! command -v uv &> /dev/null; then
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
else
  echo "uv already installed, skipping..."
fi

# cargo-binstall
if ! command -v cargo-binstall &> /dev/null; then
  echo "Installing cargo-binstall..."
  curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash
else
  echo "cargo-binstall already installed, skipping..."
fi

# brew 패키지 (CLI + GUI 앱 + 폰트)
echo "Installing brew packages..."
BREWFILE="$(mktemp)"
if curl -fsSL "$BASE_URL/homebrew/Brewfile" -o "$BREWFILE"; then
  # brew bundle은 cask에 --adopt를 자동으로 붙이므로 수동 설치된 앱과 충돌하지 않는다.
  # 일부 패키지가 실패해도 설정 파일 동기화는 계속되어야 하므로 non-fatal로 둔다.
  if ! brew bundle --file "$BREWFILE"; then
    echo "  ⚠️  brew bundle had failures — continuing"
    FAILURES=$((FAILURES + 1))
  fi
else
  echo "  ⚠️  Brewfile download failed, skipping brew bundle"
  FAILURES=$((FAILURES + 1))
fi
rm -f "$BREWFILE"

# zsh plugins
echo "Setting up zsh plugins..."
ZSH_PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

clone_plugin() {
  local name="$1" url="$2"
  if [ ! -d "$ZSH_PLUGIN_DIR/$name" ]; then
    echo "Installing $name..."
    git clone --depth 1 "$url" "$ZSH_PLUGIN_DIR/$name"
  else
    echo "$name already installed, skipping..."
  fi
}

clone_plugin zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
clone_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
clone_plugin zsh-hangul https://github.com/gomjellie/zsh-hangul.git

# Download config files
echo "Downloading configuration files..."

echo "Updating zed configs..."
download "$BASE_URL/zed/settings.json" "$HOME/.config/zed/settings.json"
download "$BASE_URL/zed/keymap.json" "$HOME/.config/zed/keymap.json"
download "$BASE_URL/zed/snippets/tsx.json" "$HOME/.config/zed/snippets/tsx.json"

echo "Updating zshrc..."
download "$BASE_URL/zsh/.zshrc" "$HOME/.zshrc"

# Rectangle은 실행 중이면 설정 파일을 읽지 않는다. 종료 -> 배치 -> 재실행.
echo "Updating rectangle config..."
RECTANGLE_WAS_RUNNING=0
if pgrep -xq Rectangle; then
  RECTANGLE_WAS_RUNNING=1
  osascript -e 'quit app "Rectangle"' 2>/dev/null || true
fi
download "$BASE_URL/rectangle/RectangleConfig.json" "$HOME/Library/Application Support/Rectangle/RectangleConfig.json"
if [ "$RECTANGLE_WAS_RUNNING" -eq 1 ]; then
  open -a Rectangle 2>/dev/null || true
fi

# macOS 시스템 설정
echo "Applying macOS defaults..."
MACOS_SCRIPT="$(mktemp)"
if curl -fsSL "$REPO_BASE/scripts/macos.sh" -o "$MACOS_SCRIPT"; then
  bash "$MACOS_SCRIPT"
else
  echo "  ⚠️  macos.sh download failed, skipping"
  FAILURES=$((FAILURES + 1))
fi
rm -f "$MACOS_SCRIPT"

if [ "$FAILURES" -gt 0 ]; then
  echo "⚠️  Setup finished with $FAILURES failure(s) — see warnings above."
  exit 1
fi

echo "✅ Setup complete! Run 'source ~/.zshrc' to apply changes or restart your terminal."
echo "   수동 설치 필요: Orca (https://github.com/stablyai/orca/releases)"
