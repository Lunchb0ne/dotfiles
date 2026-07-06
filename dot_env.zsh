# Environment variables and shell utilities.
export ZSH_COMP_DIR="$HOME/.zsh/comp/"
export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"

# Override zsh-eza plugin defaults to match our eza alias.
export _EZA_PARAMS=(--icons=always --group-directories-first --git --time-style=relative --color-scale=all)

# Better man-page colors.
export LESS_TERMCAP_md="$(tput bold 2>/dev/null; tput setaf 2 2>/dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2>/dev/null)"

# Let z4h manage keybinds; atuin stays hands-off.
export ATUIN_NOBIND=true

# Use `bat` as the man-page viewer when available.
if command -v bat >>/dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Fix cursor when it gets stuck in block mode.
_fix_cursor() {
    echo -ne "\e[3 q"
}
add-zsh-hook precmd _fix_cursor

# Enrich FPATH and deduplicate paths.
fpath+=("$ZSH_COMP_DIR")
typeset -U path PATH
typeset -U fpath FPATH

# Cache shell completion files to avoid regeneration.
# arg1: the command
# arg2: the command that generates completions
function completion_cacher() {
    if (($ +commands["$1"])); then
        if [[ ! -f "$ZSH_COMP_DIR/_$1" ]]; then
            typeset -g -A _comps
            autoload -Uz "_$1"
            _comps["$1"]="_$1"
        fi
        eval "$2" >| "$ZSH_COMP_DIR/_$1" &|
    fi
}
