# Almost of my environment variables
export ZSH_COMP_DIR="$HOME/.zsh/comp/"
export GPG_TTY=$TTY                # Use current TTY for GPG.
export ATUIN_NOBIND="true"

# Use `bat` as the man-page viewer.
# Only do this if bat is installed
if command -v bat >>/dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export HOMEBREW_BAT=1 # And for Homebrew too.
fi

# Fix cursor sometimes when it gets stuck
_fix_cursor() {
    echo -ne "\e[3 q"
}
add-zsh-hook precmd _fix_cursor

# Use 1pw for ssh agent.
export SSH_AUTH_SOCK=~/.1password/agent.sock

# Export path for go-lang.
export GOPATH=~/go/

# Enrich PATH.
# Override
path=(
    $HOME/bin
    $path
    $GOPATH/bin
)

# Enrich FPATH.
fpath+=( $ZSH_COMP_DIR)

# Make paths unique
typeset -U path PATH
typeset -U fpath FPATH

# arg1: the command
# arg2: the command that we should use to generate completions
function completion_cacher() {
    if (($ +commands["$1"])); then
        # If the completion file doesn't exist yet, we need to autoload it and
        # bind it to `$1`. Otherwise, compinit will have already done that.
        if [[ ! -f "$ZSH_COMP_DIR/_$1" ]]; then
            typeset -g -A _comps
            autoload -Uz "_$1"
            _comps["$1"]="_$1"
        fi

      eval "$2" >| "$ZSH_COMP_DIR/_$1" &|
    fi
}
