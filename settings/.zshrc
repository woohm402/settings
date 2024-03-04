# alias
alias ppc="pwd | xargs echo 'cd' | pbcopy"
alias cdc="cd ~/code"
alias cdm="cd ~/code/mathpresso"
alias cdmqf="cd ~/code/mathpresso/qanda-frontend"
alias cdmacaw="cd ~/code/mathpresso/qanda-frontend/services/adaptivecontent-admin-web"
alias cdmqds="cd ~/code/mathpresso/qanda-frontend/libraries/qanda-design-system"
alias cdmqauw="cd ~/code/mathpresso/qanda-frontend/services/qanda-ai-user-web"
alias cdmlw="cd ~/code/mathpresso/qanda-frontend/services/lms-web"
alias cdw="cd ~/code/wafflestudio"
alias cdwsew="cd ~/code/wafflestudio/snutt-ev-web"
alias cdwsw="cd ~/code/wafflestudio/snutt-webclient"
alias cdwsw2="cd ~/code/wafflestudio/snutt-webclient-v2"

# git
plugins=(git)

# appearance
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
precmd() { echo; }

# node
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

export PATH="$(yarn global bin):$PATH"

# pip
export PATH=$PATH:~/Library/Python/3.8/bin

# gcp
if [ -f '~/.google-cloud-sdk/path.zsh.inc' ]; then . '~/.google-cloud-sdk/path.zsh.inc'; fi
if [ -f '~/.google-cloud-sdk/completion.zsh.inc' ]; then . '~/.google-cloud-sdk/completion.zsh.inc'; fi

eval $(thefuck --alias)

# zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="lambda"
source $ZSH/oh-my-zsh.sh

# android emulator
export PATH=$PATH:~/Library/Android/sdk/emulator/
export PATH=$PATH:~/Library/Android/sdk/platform-tools/
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# java
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export PATH=$JAVA_HOME/bin:$PATH

PATH=~/.console-ninja/.bin:$PATH
