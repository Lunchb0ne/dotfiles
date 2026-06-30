#!/bin/zsh

# Almost of my environment variables
export ZSH_COMP_DIR="$HOME/.zsh/comp/"
export GPG_TTY=$TTY

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

# LS_COLORS via vivid (cached — regenerates when vivid binary updates)
_ls_colors_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/ls_colors"
if [[ ! -f "$_ls_colors_cache" || "$(command -v vivid)" -nt "$_ls_colors_cache" ]]; then
  mkdir -p "${_ls_colors_cache:h}"
  vivid generate catppuccin-mocha >"$_ls_colors_cache"
fi
export LS_COLORS="$(<$_ls_colors_cache)"
unset _ls_colors_cache

# arg1: the command
# arg2: the command that we should use to generate completions
function completion_cacher() {
  if (($ + commands["$1"])); then
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
