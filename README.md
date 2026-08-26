# dotfiles

Chezmoi source for a macOS setup. It sets up Zsh, Git, SSH, Mise, Neovim,
Bat, Atuin, and Ghostty.

The files target macOS on Apple silicon. They use Homebrew and 1Password paths.

## Install

Install Homebrew. Then install Chezmoi.

```sh
brew install chezmoi
```

Get the source state and install the declared Homebrew packages.

```sh
chezmoi init Lunchb0ne/dotfiles
brew bundle --file="$HOME/.local/share/chezmoi/Brewfile"
```

Apply the configuration. Install the Mise tools. Then start a new Zsh session.

```sh
chezmoi apply
mise install
exec zsh
```

Install and configure 1Password before you sign commits or use the SSH agent.
The Git configuration uses 1Password to sign commits with an SSH key.

## Mise tools

Mise installs Aube so that `aubx` can run one-off Node.js tools. Mise continues
to use Bun to install declared `npm:` tools. `pipx.uvx = true` makes Mise use
`uvx` for `pipx:` tools when `uv` is available.

The source clone uses the SSH GitHub remote. If a new clone uses HTTPS, change
it after you configure the 1Password SSH agent:

```sh
chezmoi git -- remote set-url Lunchb0ne git@github.com:Lunchb0ne/dotfiles.git
```

## Update

Use Chezmoi to check and apply changes.

```sh
chezmoi status
chezmoi diff
chezmoi apply
```

Edit a managed target with Chezmoi. For example:

```sh
chezmoi edit ~/.zshrc
```

Use `chezmoi git -- <command>` for source-control commands. For example:

```sh
chezmoi git -- status
```

## Agent work

Read [AGENTS.md](AGENTS.md) before you change this repository. It gives the
Chezmoi rules, the required Zsh order, and the validation commands.

## Layout

| Source path | Target path | Use |
| --- | --- | --- |
| `dot_zshrc` | `~/.zshrc` | Interactive shell startup. |
| `dot_zimrc` | `~/.zimrc` | Zim module list. |
| `dot_env.zsh` | `~/.env.zsh` | Environment variables, paths, and completion cache helpers. |
| `dot_alias.zsh` | `~/.alias.zsh` | Aliases and completion definitions for local functions. |
| `dot_style.zsh` | `~/.style.zsh` | `LS_COLORS` generation and completion styles. |
| `dot_p10k.zsh` | `~/.p10k.zsh` | Powerlevel10k prompt settings. |
| `dot_config/` | `~/.config/` | Application configuration. |
| `dot_config/vivid/themes/pierre-dark.yml` | `~/.config/vivid/themes/pierre-dark.yml` | Pierre Dark colors for file listings. |
| `dot_config/eza/theme.yml` | `~/.config/eza/theme.yml` | Pierre Dark eza file, Git, and metadata colors. |
| `dot_config/bat/themes/Pierre Dark.tmTheme` | `~/.config/bat/themes/Pierre Dark.tmTheme` | Pierre Dark syntax highlighting. |
| `dot_config/ghostty/config` | `~/.config/ghostty/config` | Pierre Dark terminal palette and Ghostty settings. |
| `dot_gitconfig` | `~/.gitconfig` | Git identity, SSH commit signing, and defaults. |
| `dot_ssh/config` | `~/.ssh/config` | SSH hosts and the 1Password SSH agent. |
| `Brewfile` | Repository only | Homebrew package list. |

Chezmoi ignores [README.md](README.md), [AGENTS.md](AGENTS.md), and
[Brewfile](Brewfile). It does not copy them to the home directory.

## Zsh startup order

Zsh starts in this order.

1. Powerlevel10k instant prompt loads first.
2. `dot_env.zsh` sets `PATH`, `fpath`, and completion cache helpers.
3. Zsh options and Zim settings load.
4. Zim loads modules in the order in `dot_zimrc`.
5. The Zim completion module runs `compinit`.
6. fzf-tab loads before plugins that wrap ZLE widgets.
7. `dot_alias.zsh` loads after `compinit`, because it uses `compdef`.
8. `dot_style.zsh` loads after Zim. Mise has added `vivid` to `PATH`.
   The style file overrides Zim completion styles.
9. Powerlevel10k settings load last.

`dot_zimrc` puts completion providers before the Zim completion module.
It puts fzf-tab after completion and before Fast Syntax Highlighting and
autosuggestions.

## Validate

Run these commands from the source directory.

```sh
zsh -n dot_zshrc dot_zimrc dot_env.zsh dot_alias.zsh dot_style.zsh dot_p10k.zsh
git config --file dot_gitconfig --list
chezmoi git -- diff --check
```

Run the Zsh test with Mise:

```sh
mise -C dot_config/mise exec -- bats "$PWD/tests/dot_style.bats"
```

Check the Mise and Zsh style path with:

```sh
mise -C dot_config/mise exec -- zsh -fc \
  'source "$1"; source "$2"; [[ -n "$LS_COLORS" ]]' \
  -- "$PWD/dot_env.zsh" "$PWD/dot_style.zsh"
```
