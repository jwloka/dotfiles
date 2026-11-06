fpath=($fpath $HOME/.zsh/func)
typeset -U fpath

# Plot: Bitbucket-Login für «Only my work» auf dem Board (Bitbucket nennt ihn ohne API-Anfrage nicht).
# In .zshenv statt .zshrc, damit auch nicht-interaktive Shells ihn kennen (Board, Skripte).
export PLOT_BUDGET_ACCOUNT=jwloka

# The highlighters directory follows Homebrew's prefix, which differs between
# Apple silicon and Intel. Set only when the directory exists: a value naming a
# missing path makes zsh-syntax-highlighting abort instead of fall back.
for _hl in /opt/homebrew /usr/local; do
  if [ -d "$_hl/share/zsh-syntax-highlighting/highlighters" ]; then
    export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="$_hl/share/zsh-syntax-highlighting/highlighters"
    break
  fi
done
unset _hl

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
  # `alias/default` may name another alias ("lts/*" → "lts/lithium" → "v26.13.0");
  # follow the chain, and give up unless it ends at a version.
  _hop=0
  while [ -f "$HOME/.nvm/alias/$_pn" ] && [ $_hop -lt 5 ]; do
    _pn="$(cat "$HOME/.nvm/alias/$_pn" 2>/dev/null)"; _hop=$((_hop + 1))
  done
  unset _hop
  case "${_pn#v}" in [0-9]*) ;; *) _pn= ;; esac
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
