#!/bin/zsh

# Define functions and completions.
function md() {
    [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1"
}
compdef _directories md

# Handy Shortcut to remove quarantine.
function rq() {
    xattr -d com.apple.quarantine "$@"
}
compdef _files rq

# Open dir in Gitkraken.
function krak() {
    dir="$(
        cd "$(dirname "$1")"
        pwd -P
    )/$(basename "$1")"
    open gitkraken://repo/$dir
}
compdef _directories krak

# Let mamba use conda completions.
compdef _conda mamba

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Define aliases.
alias tree='tree -a -I .git'

# ls helper aliases.
alias l='ls -lA'
alias lt='ls -A --tree'

# Check if lsd is installed, to alias ls to lsd.
if command -v lsd >>/dev/null; then
    alias ls='lsd'
    alias ls_="$(where ls | sed '2q;d')" # Old ls command for compatibility.
fi

# Check if bat is installed, then alias cat to bat.
if command -v bat >>/dev/null; then
    alias cat='bat --paging=never'
    alias cat_="$(where cat | sed '2q;d')" # Old cat for compat.
fi

alias python='python3' # Python alias.
alias pip='pip3'       # Pip alias.

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"
