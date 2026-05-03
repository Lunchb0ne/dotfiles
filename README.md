# dotfiles

Managed with [chezmoi](https://chezmoi.io/). Branch `niri-wl` targets Arch Linux with niri compositor.

## Layout

```
~/.config/mise/config.toml      tool versions (bun, aube, node, uv, etc.)
~/.zshenv                       z4h bootstrap + EDITOR
~/.zshrc                        z4h framework, sources sub-files
~/.env.zsh                      exports, MANPAGER, completion cacher
~/.alias.zsh                    eza, bat, pacman, build aliases
~/.config/niri/                 niri compositor config (hand-edited only)
~/.config/opencode/             opencode settings
~/.config/qt6ct/                Qt6 theme
~/.config/environment.d/        session environment variables
```

## zsh

Built on [zsh4humans](https://github.com/romkatv/zsh4humans) (v5). `.zshrc` is thin — framework setup only. Customizations live in sourced files:

| File | Purpose |
|------|---------|
| `.env.zsh` | `SSH_AUTH_SOCK` (1Password), `MANPAGER` (bat), cursor fix, `completion_cacher` |
| `.alias.zsh` | `eza --icons=always`, `bat` for cat, pacman shortcuts |

### Plugins

- [zoxide](https://github.com/ajeetdsouza/zoxide) — smart directory jumper
- [atuin](https://atuin.sh) — synced shell history (Ctrl+R)
- [zsh-mise](https://github.com/wintermi/zsh-mise) — mise integration
- [zsh-eza](https://github.com/z-shell/zsh-eza) — eza aliases and completions

### SSH teleport

`.env.zsh` and `.alias.zsh` are teleported to remote hosts on SSH. No dotfile cloning needed on remotes.

## niri

Only hand-edited files are tracked. DMS auto-generated files (colors, layout, outputs, profiles) are in `.chezmoiignore`.

## Bootstrap

```sh
# Install chezmoi, then:
chezmoi init --apply Lunchb0ne/dotfiles --branch niri-wl
```
