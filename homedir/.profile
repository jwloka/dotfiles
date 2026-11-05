#############################################################
# Generic configuration that applies to all shells
#############################################################

source ~/.shellvars
source ~/.shellfn
source ~/.shellpaths
source ~/.shellaliases
source ~/.iterm2_shell_integration.`basename $SHELL`
# Private/Proprietary shell aliases (not to be checked into the public repo) :)
#source ~/Dropbox/Private/Boxes/osx/.shellaliases

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/jwloka/.lmstudio/bin"
# End of LM Studio CLI section


# NODE COMES FROM NVM IN BASH TOO. `bash -lc` reads this file and no zsh one, so
# without it a bash login shell falls through to Homebrew's node — 26.7.0, which
# `pnpm` crashes on. POSIX sh syntax, because this file is shell-agnostic.
if [ -r "$HOME/.nvm/alias/default" ]; then
  _pn=$(cat "$HOME/.nvm/alias/default" 2>/dev/null)
  _pb=$(ls -d "$HOME"/.nvm/versions/node/v"${_pn#v}"*/bin 2>/dev/null | sort -V | tail -1)
  if [ -n "$_pb" ] && [ -x "$_pb/node" ]; then
    case ":$PATH:" in
      ":$_pb:"*) : ;;
      *) PATH="$_pb:$PATH"; export PATH ;;
    esac
  fi
  unset _pn _pb
fi
