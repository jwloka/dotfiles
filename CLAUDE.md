# dotfiles

Personal macOS machine setup: shell config, packages, and system defaults.
Fork of `atomantic/dotfiles` (`origin` = `jwloka/dotfiles`, `upstream` = `atomantic/dotfiles`).

## Critical Rules

1. **NEVER run `install.sh` or `restore.sh`.** They are interactive, use sudo, rewrite macOS `defaults`, and install software. Edit them; the user runs them.
2. **Linked files are live.** `homedir/*`, `configs/zed/settings.json` and `configs/ssh/config` are symlinked into `~/`; an edit takes effect immediately. After editing a shell file, syntax-check it (see Commands).
3. **NEVER edit submodule contents** (`oh-my-zsh/`, `z-zsh/`, `homedir/.vim/bundle/Vundle.vim/`). They are third-party.
4. **NEVER commit secrets or machine-specific identity.** Signing keys, `commit.gpgsign` and credential-helper paths belong in `~/.gitconfig.local` (included last by `.gitconfig`, not in the repo). Alternate git identities go in the ignored `homedir/.gitconfig_*`.

## Layout

| Path | Purpose |
|------|---------|
| `homedir/` | Dotfiles, symlinked as `~/<name>` by `install.sh` |
| `configs/` | Zed settings, SSH config (both linked by `install.sh`), iTerm/Terminal colors, `hosts` |
| `config.js` | Package lists: `brew`, `cask`, `gem`, `npm` (consumed by `index.js`) |
| `install.sh` | Bootstrap: brew, symlinks, Vim, fonts, packages, macOS `defaults` |
| `restore.sh` | Restore from `~/.dotfiles_backup/<date>/` |
| `scripts/` | Standalone helpers (`yt-audio-download`, `yt-video-download`) |
| `lib_sh/` | `echos.sh` (`bot`, `running`, `ok`), `requirers.sh` |

## Shell Load Order

- `.zshenv` (every shell): nvm's node ahead of Homebrew's, zsh-syntax-highlighting dir, `PLOT_BUDGET_ACCOUNT`
- `.zprofile` (login) → `.profile` → `.shellvars`, `.shellfn`, `.shellpaths`, `.shellaliases`; re-asserts node-first after `path_helper`
- `.zshrc` (interactive): detects `$BREW_PREFIX`, defines `src`, loads oh-my-zsh, `docker-aliases.sh`, Homebrew zsh plugins, SDKMAN

Conventions:
- New aliases → `.shellaliases`, functions → `.shellfn`, `PATH` → `.shellpaths`, exports → `.shellvars`.
- Build Homebrew paths from `$BREW_PREFIX`; never hardcode `/opt/homebrew` (Intel uses `/usr/local`).
- Source optional files with `src <file>`, which no-ops when the file is missing.
- The node-first block exists in both `.zshenv` and `.zprofile` on purpose; change both together.

## Commands

```bash
zsh -n homedir/.zshrc            # syntax-check zsh files
bash -n homedir/.shellaliases    # syntax-check sh-compatible files
node -e "require('./config.js')" # validate config.js after editing
zsh -i -c exit                   # smoke-test a full interactive shell
```

There is no test suite (`npm test` is a stub).

## Important Notes

- Adding a package: append it to the right list in `config.js`, keep alphabetical order.
- `homedir/.vim/bundle/*` is gitignored except Vundle; don't commit plugin checkouts or archives.
- Use `trash`, not `rm`.

## Git

- Branch: `master`. Commit with Quatico/Arlo notation (`f`, `r`, `e`, ...); see the `commit-notation` skill.
- Don't merge from `upstream` without asking.
