#!/bin/zsh

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
# preview files with bat when completing common commands
zstyle ':fzf-tab:complete:(cat|bat|less|vim|nvim):*' fzf-preview 'bat --color=always --style=numbers --line-range=:100 $realpath 2>/dev/null || eza -1 --color=always $realpath'
# preview process info when completing kill/ps
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps -p $word -o pid,user,comm,stat,%cpu,%mem'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
# preview env vars
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# Fix cursor sometimes when it gets stuck
_fix_cursor() {
    echo -ne "\e[3 q"
}
