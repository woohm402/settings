#!/bin/bash
# macOS 시스템 설정. 현재 머신에서 실제로 바꿔 쓰던 값만 담는다.
# 기본값 그대로인 항목(키 리피트 속도 등)은 의도적으로 넣지 않음.
set -euo pipefail

echo "Applying macOS defaults..."

# 스크린샷: 파일 대신 클립보드로, 영역 선택 모드
defaults write com.apple.screencapture target -string "clipboard"
defaults write com.apple.screencapture style -string "selection"

# Dock: 왼쪽 배치, 작은 아이콘
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock tilesize -int 26

# Finder: 경로 막대 표시, 갤러리 뷰 기본
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "glyv"

# 자동 교정 끄기 (코드/터미널에서 방해됨)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

killall Dock 2>/dev/null || true
killall Finder 2>/dev/null || true

echo "✅ macOS defaults applied."
