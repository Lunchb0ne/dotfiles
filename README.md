# Dotfiles

My personal configuration files (dotfiles) for macOS, managed with profiles.

## 🛠️ Configuration Overview

This repository contains configurations for my development environment, organized into profiles.

### Core Tools

- **Shell:** [Zsh](https://www.zsh.org/)
  - Framework: [Zim](https://zimfw.sh/) for fast module management.
  - Theme: [Powerlevel10k](https://github.com/romkatv/powerlevel10k) for a fast, flexible prompt.
- **Editor:** [Neovim](https://neovim.io/)
  - Distribution: [LazyVim](https://www.lazyvim.org/) starter template.
- **Terminal:** [WezTerm](https://wezfurlong.org/wezterm/) - A GPU-accelerated cross-platform terminal emulator.
- **Utilities:**
  - [Bat](https://github.com/sharkdp/bat): A `cat` clone with syntax highlighting and Git integration.

## 📂 Structure

The configurations are stored in the `default` directory, which serves as the main profile.

```text
default/
├── .config/
│   ├── bat/        # Bat configuration & Catppuccin themes
│   ├── nvim/       # LazyVim configuration
│   └── wezterm/    # WezTerm lua config
├── .ssh/           # SSH config
├── .p10k.zsh       # Powerlevel10k config
└── .zsh*           # Zsh environment and rc files
```

## 🎨 Themes

- **Bat:** configured with [Catppuccin](https://github.com/catppuccin/bat) themes.
