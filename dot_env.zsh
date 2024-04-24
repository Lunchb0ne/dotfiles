# Almost of my environment variables
export ZSH_COMP_DIR="$HOME/.zsh/comp/"
export GPG_TTY=$TTY                # Use current TTY for GPG.

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Fix cursor sometimes when it gets stuck
_fix_cursor() {
    echo -ne "\e[3 q"
}

# Use 1pw for ssh agent.
export SSH_AUTH_SOCK=~/.1password/agent.sock
# Export path for go-lang.
export GOPATH=~/go

# Enrich PATH.
path=(
    /opt/homebrew/bin
    $HOME/bin
    $path
    $GOPATH/bin
)

# Enrich FPATH.
fpath+=($ZSH_COMP_DIR)

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
