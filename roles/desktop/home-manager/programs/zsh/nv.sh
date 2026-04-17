# zsh function - sourced, not executed
function nv() {
  local found_jnum tmpfile jnum_raw flag pid rest
  tmpfile=$(mktemp)
  jobs -l > "$tmpfile"
  while read -r jnum_raw flag pid rest; do
    if [[ "$(ps -p "$pid" -o comm= 2>/dev/null)" == *nvim* ]]; then
      found_jnum=${jnum_raw[2,-2]}
      break
    fi
  done < "$tmpfile"
  rm -f "$tmpfile"
  if [[ -n "$found_jnum" ]]; then
    fg %"$found_jnum"
  else
    nvim "$@"
  fi
}
