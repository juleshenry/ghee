#!/usr/bin/env bats

@test "Check Bash syntax for all modules" {
  for module in modules/*.sh; do
    run bash -n "$module"
    [ "$status" -eq 0 ]
  done
}

@test "Check setup script syntax" {
  run bash -n setup-ghee
  [ "$status" -eq 0 ]
}

@test "Check ghee-functions syntax" {
  run bash -n ghee-functions.sh
  [ "$status" -eq 0 ]
}

@test "Ensure modules define _GG_REGISTRY" {
  for module in modules/*.sh; do
    run grep -q "_GG_REGISTRY\[" "$module"
    [ "$status" -eq 0 ]
  done
}

@test "Registry entries have no trailing characters after the closing quote" {
  run grep -nE '^_GG_REGISTRY\[.*"[^"]+$' modules/*.sh
  [ "$status" -eq 1 ]
}

@test "Every registry key is defined as an alias or function" {
  all="$(cat modules/*.sh)"
  missing=""
  for f in modules/*.sh; do
    for k in $(grep -o '_GG_REGISTRY\["[^"]*"\]' "$f" | sed 's/_GG_REGISTRY\["//;s/"\]//'); do
      grep -qE "^[[:space:]]*(alias ${k}=|${k}[[:space:]]*\(\)|function ${k})" <<<"$all" || missing="$missing $f:$k"
    done
  done
  [ -z "$missing" ] || { echo "Undefined registry keys:$missing"; false; }
}

@test "All modules source cleanly together" {
  run bash -c 'source ./ghee-functions.sh && for m in modules/*.sh; do source "$m" || exit 1; done'
  [ "$status" -eq 0 ]
}
