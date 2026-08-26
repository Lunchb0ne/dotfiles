# Agent instructions

## Scope

This repository is a Chezmoi source directory. Chezmoi writes these files to
the home directory.

The target is macOS on Apple silicon. The configuration uses Homebrew and
1Password paths. Use a Chezmoi template before you add support for another OS
or CPU architecture.

| Source path | Target path |
| --- | --- |
| `dot_*` | `~/.<name>` |
| `dot_config/*` | `~/.config/*` |
| `dot_ssh/config` | `~/.ssh/config` |

Chezmoi ignores `AGENTS.md`, `Brewfile`, and `README.md`. These files stay in
the source repository.

Read [README.md](README.md) for the managed components and the Zsh startup
order.

## Chezmoi work

- Edit source files for configuration changes.
- Use `chezmoi add <target>` after a user changes a target file.
- Use `chezmoi forget --force <target>` to stop managing a target file.
- Run `chezmoi diff` and `chezmoi status` before `chezmoi apply`.
- Apply a single target when possible: `chezmoi apply <target>`.
- Use `chezmoi git -- <command>` for Git commands.
- Keep the `Lunchb0ne` remote on `git@github.com:Lunchb0ne/dotfiles.git`.

Do not copy, link, move, or delete files between the source directory and the
home directory by hand. Do not use `chezmoi merge` in a non-interactive
session.

## Zsh work

Keep the startup order in [dot_zshrc](dot_zshrc).

1. Load the Powerlevel10k instant prompt first.
2. Set `PATH` and `fpath` before Zim runs `compinit`.
3. Put completion providers before `zmodule completion` in [dot_zimrc](dot_zimrc).
4. Load fzf-tab after completion and before plugins that wrap ZLE widgets.
5. Load aliases after `compinit`, because they use `compdef`.
6. Load styles after Zim. The style file uses Mise-managed `vivid`.
7. Load [dot_p10k.zsh](dot_p10k.zsh) last.

Do not move a Zsh fragment without checking its dependencies.

## Validation

Run these commands after shell or Git configuration changes.

```sh
zsh -n dot_zshrc dot_zimrc dot_env.zsh dot_alias.zsh dot_style.zsh dot_p10k.zsh
git config --file dot_gitconfig --list
chezmoi git -- diff --check
```

Run the Zsh test with Mise:

```sh
mise -C dot_config/mise exec -- bats "$PWD/tests/dot_style.bats"
```

Run this command after changes to Mise or the Zsh style file.

```sh
mise -C dot_config/mise exec -- zsh -fc \
  'source "$1"; source "$2"; [[ -n "$LS_COLORS" ]]' \
  -- "$PWD/dot_env.zsh" "$PWD/dot_style.zsh"
```
