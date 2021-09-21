# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.dotfiles/oh-my-zsh
export PATH=./node_modules/.bin:/usr/local/opt/ruby/bin:$PATH
# if you want to use this, change your non-ascii font to Droid Sans Mono for Awesome
# POWERLEVEL9K_MODE='awesome-patched'
export ZSH_THEME="powerlevel9k/powerlevel9k"
# export ZSH_THEME="agnoster"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
# https://github.com/bhilburn/powerlevel9k#customizing-prompt-segments
# https://github.com/bhilburn/powerlevel9k/wiki/Stylizing-Your-Prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir nvm vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history time)
# colorcode test
# for code ({000..255}) print -P -- "$code: %F{$code}This is how your text would look like%f"
POWERLEVEL9K_NVM_FOREGROUND='000'
POWERLEVEL9K_NVM_BACKGROUND='072'
POWERLEVEL9K_SHOW_CHANGESET=true
#export ZSH_THEME="random"

###
###

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# disable colors in ls
# export DISABLE_LS_COLORS="true"

# disable autosetting terminal title.
export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.dotfiles/oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colorize compleat dirpersist autojump history cp brew chucknorris common-aliases docker encode64 git gitfast git-extras git-flow gradle jira mvn node npm osx sublime sudo vscode yarn)

source $ZSH/oh-my-zsh.sh

source /usr/local/opt/nvm/nvm.sh
source ~/.dotfiles/docker-aliases.sh

autoload -U add-zsh-hook

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use &> /dev/null
  else
    nvm use stable
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# zsh completions
#plugins=(… zsh-completions)
autoload -U compinit && compinit

# set java home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

# Customize to your needs...
unsetopt correct

# run fortune on new terminal :)
fortune

fpath=(/usr/local/share/zsh-completions $fpath)


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source "/usr/local/opt/zsh-git-prompt/zshrc.sh"
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh

function options() {
    PLUGIN_PATH="$HOME/.dotfiles/oh-my-zsh/plugins/"
    for plugin in $plugins; do
        echo "\n\nPlugin: $plugin"; grep -r "^function \w*" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/()//'| tr '\n' ', '; grep -r "^alias" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/=.*//' |  tr '\n' ', '
    done
}

# aliasses
alias lz='lazygit'
alias yd='yarn dist'
alias yw='yarn watch'
alias yc='yarn clean'
alias yl='yarn lint'
alias yli='yarn link'
alias yuli='yarn unlink'
alias gc='git clean -fdx'
