# pnpm aliases (pin, pa, pr, ...) from the omz-plugin-pnpm submodule, which names its file pnpm.plugin.zsh
# skips quietly when the submodule is not checked out (git submodule update --init zsh-custom)
_pnpm_aliases_plugin="${0:A:h}/../../vendor/omz-plugin-pnpm/pnpm.plugin.zsh"
[[ -f $_pnpm_aliases_plugin ]] && source "$_pnpm_aliases_plugin"
unset _pnpm_aliases_plugin
