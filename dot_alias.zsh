#!/bin/zsh

function md() {
    [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1"
}
compdef _directories md

# Handy Shortcut to remove quarantine.
function rq() {
    xattr -d com.apple.quarantine "$@"
}
compdef _files rq

# Define aliases.
alias tree='tree -a -I .git'
alias rm='trash $@'

# Check if exa is installed, to alias ls to lsd.
if command -v eza >>/dev/null; then
    alias ls_="$(where ls)" # Old ls command for compatibility.
    alias ls='eza'
    # Add flags to existing aliases.
    alias ls="${aliases[ls]:-ls} --icons --color"
fi

# Check if bat is installed, then alias cat to bat.
if command -v bat >>/dev/null; then
    alias cat_="$(where cat)" # Old cat for compat.
    alias cat='bat'
fi

# Use `bat` as the man-page viewer.
# Only do this if bat is installed
if command -v bat >>/dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export HOMEBREW_BAT=1 # And for Homebrew too.
fi
