# Aliases and short functions.

function mkcd() { mkdir -p -- "$@" && cd -- "$_"; }
function md() {
    [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1"
}
compdef _directories md mkcd

# ---------- eza / ls ----------
alias tree='tree -a -I .git'
alias eza='eza --icons=always'
alias ls="${aliases[ls]:-ls} -A"

# ---------- bat / cat ----------
if command -v bat >>/dev/null; then
    alias cat_="$(where cat)"
    alias cat='bat'
fi

# ---------- build tools ----------
alias make="make -j$(nproc)"
alias ninja="ninja -j$(nproc)"
alias n='ninja'

# ---------- pacman ----------
alias update='sudo pacman -Syu'
alias rmpkg='sudo pacman -Rsn'
alias cleanup='sudo pacman -Rsn $(pacman -Qtdq)'
alias cleanch='sudo pacman -Scc'
alias fixpacman='sudo rm /var/lib/pacman/db.lck'

# ---------- system ----------
alias c='clear'
alias please='sudo'
alias jctl='journalctl -p 3 -xb'
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias tb='nc termbin.com 9999'

# ---------- humor ----------
alias apt='man pacman'
alias apt-get='man pacman'
