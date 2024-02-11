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

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
alias tree='tree -a -I .git'

# Check if exa is installed, to alias ls to lsd.
if command -v eza >>/dev/null; then
    alias ls_="$(where ls)" # Old ls command for compatibility.
    alias ls='eza'
    # Add flags to existing aliases.
    alias ls="${aliases[ls]:-ls} --icons"
fi

# Check if bat is installed, then alias cat to bat.
if command -v bat >>/dev/null; then
    alias cat_="$(where cat)" # Old cat for compat.
    alias cat='bat'
fi

alias python='python3' # Python alias.
alias pip='pip3'       # Pip alias.
