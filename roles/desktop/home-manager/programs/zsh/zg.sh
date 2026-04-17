# zsh function - sourced, not executed
function zg() {
  local jnum pid
  while IFS=' ' read -r jnum pid; do
    if [[ "$(ps -p "$pid" -o comm= 2>/dev/null)" == *lazygit* ]]; then
      fg %"$jnum" 2>/dev/null && return
    fi
  done < <(jobs -l | awk '{gsub(/[\[\]]/,"",$1); print $1, $3}')
  lazygit
}
