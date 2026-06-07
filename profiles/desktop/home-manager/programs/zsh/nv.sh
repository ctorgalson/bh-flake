# zsh function - sourced, not executed
_NV_PID=""

function nv() {
  if [[ -n "$_NV_PID" ]] && \
     [[ "$(ps -p "$_NV_PID" -o state= 2>/dev/null | tr -d ' ')" == T ]]; then
    local tmpfile jnum_raw flag pid rest
    tmpfile=$(mktemp)
    jobs -l > "$tmpfile"
    while read -r jnum_raw flag pid rest; do
      if [[ "$pid" == "$_NV_PID" ]]; then
        rm -f "$tmpfile"
        fg %"${jnum_raw[2,-2]}"
        return
      fi
    done < "$tmpfile"
    rm -f "$tmpfile"
  fi
  _NV_PID=""
  nvim "$@" &
  _NV_PID=$!
  fg %%
}
