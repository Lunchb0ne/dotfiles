#!/bin/zsh

# Almost of my environment variables
export ZSH_COMP_DIR="$HOME/.zsh/comp/"
export GPG_TTY=$TTY
export EZA_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/eza"

# Export path for go-lang.
export GOPATH=~/go

# Enrich PATH.
path=(
  "$HOME/bin"
  "/opt/homebrew/bin"
  "$HOME/.antigravity/antigravity/bin"
  $path
  "$GOPATH/bin"
)

# Enrich FPATH.
fpath+=($ZSH_COMP_DIR)

# Make paths unique
typeset -U path PATH
typeset -U fpath FPATH

# arg1: the command
# arg2: the command that we should use to generate completions
function completion_cacher() {
  if (($ + commands["$1"])); then
    mkdir -p -- "$ZSH_COMP_DIR" || return

    # If the completion file doesn't exist yet, we need to autoload it and
    # bind it to `$1`. Otherwise, compinit will have already done that.
    if [[ ! -f "$ZSH_COMP_DIR/_$1" ]]; then
      typeset -g -A _comps
      autoload -Uz "_$1"
      _comps["$1"]="_$1"
    fi

    eval "$2" >|"$ZSH_COMP_DIR/_$1" &|
  fi
}
