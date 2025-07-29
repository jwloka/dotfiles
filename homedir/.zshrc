# Path to your oh-my-zsh configuration.
export PATH=/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=./node_modules/.bin:/usr/local/opt/ruby/bin:$PATH
export PATH=/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=/opt/homebrew/opt/apr-util/bin:$PATH
export PATH=/opt/homebrew/opt/findutils/libexec/gnubin:$PATH
export PATH=/opt/homebrew/opt/openjdk/bin:$PATH

# if you want to use this, change your non-ascii font to Droid Sans Mono for Awesome
# POWERLEVEL9K_MODE='awesome-patched'
# export ZSH_THEME="powerlevel10k/powerlevel10k"
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
plugins=(colorize compleat dirpersist autojump history cp brew chucknorris common-aliases docker encode64 git gitfast git-extras git-flow gradle jira mvn node npm sublime sudo vscode yarn)
export ZSH=$HOME/.dotfiles/oh-my-zsh
source $ZSH/oh-my-zsh.sh
source /opt/homebrew/opt/nvm/nvm.sh
source ~/.dotfiles/docker-aliases.sh

autoload -U add-zsh-hook

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# For pkg-config to find apr-util you may need to set:
export PKG_CONFIG_PATH="/opt/homebrew/opt/apr-util/lib/pkgconfig"
# To use the DocBook package in your XML toolchain,
export XML_CATALOG_FILES="/opt/homebrew/etc/xml/catalog"

export GUILE_LOAD_PATH="/opt/homebrew/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="/opt/homebrew/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="/opt/homebrew/lib/guile/3.0/extensions"


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
if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
fi


# Customize to your needs...
unsetopt correct

# run fortune on new terminal :)
fortune

fpath=(/usr/local/share/zsh-completions $fpath)


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh
source "/opt/homebrew/opt/zsh-git-prompt/zshrc.sh"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme


function options() {
    PLUGIN_PATH="$HOME/.dotfiles/oh-my-zsh/plugins/"
    for plugin in $plugins; do
        echo "\n\nPlugin: $plugin"; grep -r "^function \w*" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/()//'| tr '\n' ', '; grep -r "^alias" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/=.*//' |  tr '\n' ', '
    done
}

# aliasses
alias lz='lazygit'
alias gc='git clean -fdX'
alias go='git open'

