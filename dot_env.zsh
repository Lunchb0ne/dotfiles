# Almost of my environment variables

export GPG_TTY=$TTY #Use current TTY for GPG.

# pnpm
export PNPM_HOME="/Users/lunchb0ne/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Use `bat` as the man-page viewer.
# Only do this if bat is installed
if command -v bat >>/dev/null; then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export HOMEBREW_BAT=1 # And for Homebrew too.
fi

# Export some default options for fzf theme
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Use 1pw for ssh agent.
export SSH_AUTH_SOCK=~/.1password/agent.sock

# Export path for go-lang.
export GOPATH=~/go/

# Enrich PATH.
path=(
    '~/bin'
    $path
    $GOPATH/bin
)
