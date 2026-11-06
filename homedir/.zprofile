##############################################################################
#Import the shell-agnostic (Bash or Zsh) environment config
##############################################################################
source ~/.profile

##############################################################################
# History Configuration
##############################################################################
HISTSIZE=5000               #How many lines of history to keep in memory
HISTFILE=~/.zsh_history     #Where to save history to disk
SAVEHIST=5000               #Number of history entries to save to disk
HISTDUP=erase               #Erase duplicates in the history file
setopt    appendhistory     #Append history to the history file (no overwriting)
setopt    sharehistory      #Share history across terminals
setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

##############################################################################
# z-zsh setup
##############################################################################
. ~/.dotfiles/z-zsh/z.sh
function precmd () {
  z --add "$(pwd -P)"
}

# NODE COMES FROM NVM, IN EVERY SHELL — not only interactive ones.
#
# `.zshrc` is read by interactive shells alone, so nvm was unavailable to any
# script, hook or agent-run command. Those shells fell through to Homebrew's
# node at /opt/homebrew/bin (26.7.0, a gemini-cli dependency and not removable),
# which precedes nvm on PATH and shadows every managed version.
#
# Measured 2026-09-01 in the plot repo, which pins node 24 in .nvmrc:
#   - `node -v` reported 23.3.0 or 26.7.0 depending on the shell
#   - importing a .ts rule failed ERR_UNKNOWN_FILE_EXTENSION below node 24
#   - `plot-reap.sh` then read "rule could not be asked" for all 18 worktrees
#     and kept every one, so nothing could be dispatched
#
# `nvm which` rather than `$NVM_BIN`: that variable is exported and SURVIVES an
# uninstall — it still named v23.3.0's bin minutes after that version was
# removed, so a PATH built from it pointed nowhere.
#
# The version is resolved without sourcing nvm.sh (~200ms), because .zshenv runs
# for every shell including each command an agent spawns.
if [ -z "${PLOT_NODE_ON_PATH:-}" ]; then
  _nvm_want="$(cat "$HOME/.nvm/alias/default" 2>/dev/null)"
  # It may also name another alias ("lts/*" → "lts/lithium" → "v26.13.0");
  # follow the chain, and give up unless it ends at a version.
  _nvm_hop=0
  while [ -f "$HOME/.nvm/alias/$_nvm_want" ] && [ $_nvm_hop -lt 5 ]; do
    _nvm_want="$(cat "$HOME/.nvm/alias/$_nvm_want" 2>/dev/null)"; _nvm_hop=$((_nvm_hop + 1))
  done
  unset _nvm_hop
  case "${_nvm_want#v}" in [0-9]*) ;; *) _nvm_want= ;; esac
  if [ -n "$_nvm_want" ]; then
    # `alias/default` may hold a bare major ("24"); the newest match wins.
    _nvm_bin="$(command ls -d "$HOME"/.nvm/versions/node/v"${_nvm_want#v}"*/bin 2>/dev/null | sort -V | tail -1)"
    if [ -n "$_nvm_bin" ] && [ -x "$_nvm_bin/node" ]; then
      export PATH="$_nvm_bin:$PATH"
      export PLOT_NODE_ON_PATH=1
    fi
    unset _nvm_bin
  fi
  unset _nvm_want
fi
