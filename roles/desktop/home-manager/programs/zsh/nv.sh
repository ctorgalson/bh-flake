# zsh function - sourced, not executed
function nv() {
  local jnum pid pgid
  for jnum in ${(k)jobstates}; do
    pid=${${jobstates[$jnum]##*:}%%=*}
    pgid=$(ps -p "$pid" -o pgid= 2>/dev/null | tr -d ' ')
    if [[ -n "$pgid" ]] && ps -g "$pgid" -o comm= 2>/dev/null | grep -qx 'nvim'; then
      fg %"$jnum" && return
    fi
  done
  nvim "$@"
}
