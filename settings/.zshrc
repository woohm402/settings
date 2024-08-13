# ------------------------------
#
# ███████╗██╗  ██╗███████╗██╗     ██╗
# ██╔════╝██║  ██║██╔════╝██║     ██║
# ███████╗███████║█████╗  ██║     ██║
# ╚════██║██╔══██║██╔══╝  ██║     ██║
# ███████║██║  ██║███████╗███████╗███████╗
# ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝

# zsh setting
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# appearance & behavior
ZSH_THEME="lambda"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
precmd() { echo; }

# ------------------------------
#
# ████████╗ ██████╗  ██████╗ ██╗
# ╚══██╔══╝██╔═══██╗██╔═══██╗██║
#    ██║   ██║   ██║██║   ██║██║
#    ██║   ██║   ██║██║   ██║██║
#    ██║   ╚██████╔╝╚██████╔╝███████╗
#    ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝

# directory
alias ppc="pwd | xargs echo 'cd' | pbcopy"

# git
plugins=(git)
function gswr {
  git switch -c woohm402/$(date +%Y%m%d%H%M%S)
}
function ghpr {
  open "$(git config --get remote.origin.url | sed 's/\.git//g')/pull/new/$(git branch --show-current)"
}

# thefuck
eval $(thefuck --alias)

# ------------------------------
#
# ███████╗██╗  ██╗ ██████╗ ██████╗ ████████╗ ██████╗██╗   ██╗████████╗
# ██╔════╝██║  ██║██╔═══██╗██╔══██╗╚══██╔══╝██╔════╝██║   ██║╚══██╔══╝
# ███████╗███████║██║   ██║██████╔╝   ██║   ██║     ██║   ██║   ██║
# ╚════██║██╔══██║██║   ██║██╔══██╗   ██║   ██║     ██║   ██║   ██║
# ███████║██║  ██║╚██████╔╝██║  ██║   ██║   ╚██████╗╚██████╔╝   ██║
# ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═════╝    ╚═╝
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

# ------------------------------
#
#██╗      █████╗ ███╗   ██╗ ██████╗ ██╗   ██╗ █████╗  ██████╗ ███████╗
#██║     ██╔══██╗████╗  ██║██╔════╝ ██║   ██║██╔══██╗██╔════╝ ██╔════╝
#██║     ███████║██╔██╗ ██║██║  ███╗██║   ██║███████║██║  ███╗█████╗
#██║     ██╔══██║██║╚██╗██║██║   ██║██║   ██║██╔══██║██║   ██║██╔══╝
#███████╗██║  ██║██║ ╚████║╚██████╔╝╚██████╔╝██║  ██║╚██████╔╝███████╗
#╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝

# python: pip
export PATH=$PATH:~/Library/Python/3.8/bin

# android emulator & java
export PATH=$PATH:~/Library/Android/sdk/emulator/
export PATH=$PATH:~/Library/Android/sdk/platform-tools/
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export PATH=$JAVA_HOME/bin:$PATH

# javascript: node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
export PATH="$(yarn global bin):$PATH"

# javascript: bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ------------------------------
#
# ██████╗ ██╗      █████╗ ████████╗███████╗ ██████╗ ██████╗ ███╗   ███╗
# ██╔══██╗██║     ██╔══██╗╚══██╔══╝██╔════╝██╔═══██╗██╔══██╗████╗ ████║
# ██████╔╝██║     ███████║   ██║   █████╗  ██║   ██║██████╔╝██╔████╔██║
# ██╔═══╝ ██║     ██╔══██║   ██║   ██╔══╝  ██║   ██║██╔══██╗██║╚██╔╝██║
# ██║     ███████╗██║  ██║   ██║   ██║     ╚██████╔╝██║  ██║██║ ╚═╝ ██║
# ╚═╝     ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚═╝      ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝

# gcp
if [ -f '~/.google-cloud-sdk/path.zsh.inc' ]; then . '~/.google-cloud-sdk/path.zsh.inc'; fi
if [ -f '~/.google-cloud-sdk/completion.zsh.inc' ]; then . '~/.google-cloud-sdk/completion.zsh.inc'; fi
