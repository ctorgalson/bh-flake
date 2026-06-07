# zsh function - sourced, not executed
_ZG_PID=""

function zg() {
  if [[ -n "$_ZG_PID" ]] && \
     [[ "$(ps -p "$_ZG_PID" -o state= 2>/dev/null | tr -d ' ')" == T ]]; then
    local tmpfile jnum_raw flag pid rest
    tmpfile=$(mktemp)
    jobs -l > "$tmpfile"
    while read -r jnum_raw flag pid rest; do
      if [[ "$pid" == "$_ZG_PID" ]]; then
        rm -f "$tmpfile"
        fg %"${jnum_raw[2,-2]}"
        return
      fi
    done < "$tmpfile"
    rm -f "$tmpfile"
  fi
  _ZG_PID=""
  lazygit &
  _ZG_PID=$!
  fg %%
}
