# Path to your oh-my-zsh configuration.
# HOMEBREW LIVES AT A DIFFERENT PREFIX PER ARCHITECTURE: /opt/homebrew on
# Apple silicon, /usr/local on Intel. Every path below is built from
# $BREW_PREFIX so one file serves both.
if [ -x /opt/homebrew/bin/brew ]; then
  BREW_PREFIX=/opt/homebrew
elif [ -x /usr/local/bin/brew ]; then
  BREW_PREFIX=/usr/local
else
  BREW_PREFIX=/opt/homebrew   # absent: paths below simply do not match
fi
export BREW_PREFIX

# `src` sources a file only when it is readable, so a formula that is not
# installed on this machine costs a no-op instead of an error at every prompt.
src() { [ -r "$1" ] && source "$1"; return 0; }

export PATH=${BREW_PREFIX}/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=./node_modules/.bin:/usr/local/opt/ruby/bin:$PATH
export PATH=${BREW_PREFIX}/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=${BREW_PREFIX}/opt/apr-util/bin:$PATH
export PATH=${BREW_PREFIX}/opt/findutils/libexec/gnubin:$PATH
# (removed: Homebrew openjdk 26 on PATH — JDK now managed by SDKMAN, see bottom of file)
# (removed: $JAVA_HOME was never set, so this prepended "/bin" to PATH)
export PATH=$HOME/.local/bin:$PATH

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
plugins=(colorize compleat dirpersist autojump history cp brew chucknorris common-aliases docker encode64 git gitfast git-extras git-flow gradle jira mvn node npm macos sublime sudo vscode yarn)
export ZSH=$HOME/.dotfiles/oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.dotfiles/docker-aliases.sh

autoload -U add-zsh-hook

export NVM_DIR="$HOME/.nvm"
[ -s "${BREW_PREFIX}/opt/nvm/nvm.sh" ] && \. "${BREW_PREFIX}/opt/nvm/nvm.sh"  # This loads nvm
[ -s "${BREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm" ] && \. "${BREW_PREFIX}/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# For pkg-config to find apr-util you may need to set:
export PKG_CONFIG_PATH="${BREW_PREFIX}/opt/apr-util/lib/pkgconfig"
# To use the DocBook package in your XML toolchain,
export XML_CATALOG_FILES="${BREW_PREFIX}/etc/xml/catalog"

export GUILE_LOAD_PATH="${BREW_PREFIX}/share/guile/site/3.0"
export GUILE_LOAD_COMPILED_PATH="${BREW_PREFIX}/lib/guile/3.0/site-ccache"
export GUILE_SYSTEM_EXTENSIONS_PATH="${BREW_PREFIX}/lib/guile/3.0/extensions"


load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use &> /dev/null
  else
    nvm use stable &> /dev/null
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# load ssh keys (commit signing) from the macOS Keychain after a restart
[[ $OSTYPE == darwin* ]] && ! ssh-add -l &>/dev/null && ssh-add --apple-load-keychain -q 2>/dev/null

# zsh completions
# Docker Desktop's CLI completions; must be on fpath before compinit runs
[ -d ~/.docker/completions ] && fpath=(~/.docker/completions $fpath)
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
[ -f ${BREW_PREFIX}/etc/profile.d/autojump.sh ] && . ${BREW_PREFIX}/etc/profile.d/autojump.sh
src ${BREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
src ${BREW_PREFIX}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
src ${BREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
src ${BREW_PREFIX}/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh
src "${BREW_PREFIX}/opt/zsh-git-prompt/zshrc.sh"
src ${BREW_PREFIX}/share/powerlevel10k/powerlevel10k.zsh-theme
# tabtab completions (pnpm); needs compinit, which ran above
src ~/.config/tabtab/zsh/__tabtab.zsh


function options() {
    PLUGIN_PATH="$HOME/.dotfiles/oh-my-zsh/plugins/"
    for plugin in $plugins; do
        echo "\n\nPlugin: $plugin"; grep -r "^function \w*" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/()//'| tr '\n' ', '; grep -r "^alias" $PLUGIN_PATH$plugin | awk '{print $2}' | sed 's/=.*//' |  tr '\n' ', '
    done
}

# tongue-in-cheek ai shortcuts
# Single quotes defer $(date) to each run; double quotes froze it at shell start.
alias agi='claude --permission-mode bypassPermissions --model default --append-system-prompt "Current time is: $(date)."'
alias agit='OMC_TELEGRAM=1 claude --permission-mode bypassPermissions --model default --append-system-prompt "Current time is: $(date)."'
alias agir='claude --channels plugin:telegram@claude-plugins-official --permission-mode bypassPermissions --model default --append-system-prompt "Current time is: $(date)."'
alias skynet='OMC_TELEGRAM=1 claude --dangerously-skip-permissions --model default --append-system-prompt "Current time is: $(date)."'
alias omc='node ~/.claude/plugins/cache/omc/oh-my-claudecode/4.9.3/scripts/run.cjs'

# aliasses
alias lz='lazygit'
alias gc='git clean -fdx -e .claude -e .cursor'
alias go='git open'
alias gw='./gradlew'

# yarn shortcuts. These follow the `yarn` plugin's own aliases deliberately:
# the plugin defines yd as `yarn dev` and yw as `yarn workspace`, and these
# redefine both to the project commands used here.
alias yd='yarn dist'
alias yw='yarn watch'
alias yc='yarn clean'
alias yl='yarn lint'
alias yli='yarn link'
alias yuli='yarn unlink'

export PATH="${BREW_PREFIX}/sbin:$PATH"

# Added by Antigravity
export PATH="/Users/jwloka/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# bun completions
[ -s "/Users/jwloka/.bun/_bun" ] && source "/Users/jwloka/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/jwloka/.lmstudio/bin"
# End of LM Studio CLI section

# --- SDKMAN (manages JDK/Gradle versions; must stay last so it wins on PATH) ---
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

