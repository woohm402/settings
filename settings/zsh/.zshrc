# git
function gswr {
  git switch -c woohm402/$(date +%Y%m%d%H%M%S)
}
function ghpr {
  open "$(git config --get remote.origin.url | sed 's/\.git//g')/pull/new/$(git branch --show-current)"
}

# shortcuts
alias manarc="open https://resources.arc.net/hc/en-us/articles/20595231349911-Keyboard-Shortcuts"
alias mandiscord="open https://support.discord.com/hc/en-us/articles/225878307--macOS-Discord-Hotkeys"
alias manfigma="open https://help.figma.com/hc/en-us/articles/360040328653-Keyboard-shortcuts-in-Figma"
alias mangithub="open https://docs.github.com/en/get-started/accessibility/keyboard-shortcuts"
alias mangooglecalendar="open https://support.google.com/calendar/answer/37034?hl=en"
alias mankakakotalk="open https://cs.kakao.com/helps_html/1073200262"
alias manmac="open https://support.apple.com/ko-kr/102650"
alias manmessage="open https://support.apple.com/ko-kr/guide/messages/ichtc78b3bff/mac"
alias mannotion="open https://www.notion.so/ko-kr/help/keyboard-shortcuts"
alias manobsidian="open https://help.obsidian.md/Editing+and+formatting/Editing+shortcuts"
alias manslack="open https://slack.com/intl/ko-kr/help/articles/201374536-Slack-%ED%82%A4%EB%B3%B4%EB%93%9C-%EB%8B%A8%EC%B6%95%ED%82%A4"
alias manvim="open https://vim.rtorr.com/"
alias manzshgit="open https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/README.md"

alias zad="zellij attach default"

# Languages
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export PATH="$HOME/.local/bin:$PATH" # uv

# Editor
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

# gcp
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"

# appearance & behavior
ZSH_THEME="lambda"
plugins=(git z zsh-hangul)
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
precmd() { echo; }

# zsh setting. this line should be at the end of the file.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
