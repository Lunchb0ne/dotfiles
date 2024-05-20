#!/usr/bin/env bats

load '/Users/lunchb0ne/.local/share/chezmoi/dot_env.zsh'

@test "_fix_cursor function should output correct escape sequence" {
  result="$(_fix_cursor)"
  [ "$result" = $'\e[3 q' ]
}
