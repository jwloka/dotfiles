fpath=($fpath $HOME/.zsh/func)
typeset -U fpath

# Plot: Bitbucket-Login für «Only my work» auf dem Board (Bitbucket nennt ihn ohne API-Anfrage nicht).
# In .zshenv statt .zshrc, damit auch nicht-interaktive Shells ihn kennen (Board, Skripte).
export PLOT_BUDGET_ACCOUNT=jwloka

export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/opt/homebrew/share/zsh-syntax-highlighting/highlighters

# NODE COMES FROM NVM IN NON-LOGIN SHELLS TOO — `zsh -c 'node …'`, which is the
# shape most tooling spawns.
#
# The same block lives in `.zprofile`, and it has to live twice. `.zshenv` runs
# for EVERY shell but before `/etc/zprofile`'s `path_helper`, which rebuilds PATH
# and puts /opt/homebrew/bin back in front; `.zprofile` runs after it but only
# for LOGIN shells. Neither file alone covers both, so each re-asserts.
#
# The `PLOT_NODE_ON_PATH` guard makes the second run a no-op where the first
# already won, and this one re-checks the position rather than the flag: after
# `path_helper` the flag is set and the PATH is wrong, which is exactly the case
# `.zprofile` exists to repair.
_plot_node_first() {
  _pn="$(cat "$HOME/.nvm/alias/default" 2>/dev/null)"
  [ -n "$_pn" ] || { unset _pn; return 0; }
  _pb="$(command ls -d "$HOME"/.nvm/versions/node/v"${_pn#v}"*/bin 2>/dev/null | sort -V | tail -1)"
  if [ -n "$_pb" ] && [ -x "$_pb/node" ]; then
    case ":$PATH:" in
      ":$_pb:"*) : ;;                       # already first — nothing to do
      *) export PATH="$_pb:${PATH//$_pb:/}" ;;
    esac
  fi
  unset _pn _pb
}
_plot_node_first
