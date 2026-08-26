#!/usr/bin/env bats

@test "_fix_cursor function should output correct escape sequence" {
  # shellcheck disable=SC2016 # "$1" must expand in the child Zsh.
  run env XDG_CACHE_HOME="$BATS_TEST_TMPDIR/cache" \
    XDG_CONFIG_HOME="$BATS_TEST_DIRNAME/../dot_config" \
    zsh -fc 'source "$1"; _fix_cursor' -- "$BATS_TEST_DIRNAME/../dot_style.zsh"

  [ "$status" -eq 0 ]
  [ "$output" = $'\e[3 q' ]
}
