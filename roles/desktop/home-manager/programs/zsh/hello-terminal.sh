#!/usr/bin/env bash

center_h() {
  local text="$1"
  local block_width="$2"
  local term_width="$3"
  local left_padding="$(((term_width - block_width) / 2))"
  local color="$4"

  while IFS= read -r line; do
    if [ -n "$color" ]; then
      colorstart="\033[${color}m"
      colorend="\033[0m"
      printf "${colorstart}%*s%s${colorend}\n" "$left_padding" "" "$line"
    else
      printf "%*s%s\n" "$left_padding" "" "$line"
    fi
  done <<< "$text"
}

center_v() {
  local text="$1"
  local term_height="$2"
  local text_lines="$(echo "$text" | wc -l)"
  local top_padding="$(((term_height - text_lines) / 2))"

  clear

  for ((i = 0; i < top_padding; i++)); do
    echo ""
  done

  echo "$text"

  for ((i = 0; i < top_padding; i++)); do
    echo ""
  done
}

cols="$(tput cols)"
lines="$(tput lines)"

greeting_lines="$(figlet -c "$1" -f "univers" -t)"
greeting_width="$cols"
greeting_output="$(center_h "$greeting_lines" "$greeting_width" "$cols" "1;34")"

summary_heading_lines="LATEST AV SCAN RESULTS"
summary_heading_width="$(echo "$summary_heading_lines" | tail -n1 | wc -m)"
summary_heading_output="$(center_h "$summary_heading_lines" "$summary_heading_width" "$cols" "0;31")"
                                                                           
summary_lines="$(<"/home/ctorgalson/last-clamscan.log")"
summary_width=36
summary_output="$(center_h "$summary_lines" "$summary_width" "$cols")"

weather_lines="$(curl --silent wttr.in/\?0AQ)"
weather_width=35
weather_output="$(center_h "$weather_lines" "$weather_width" "$cols")"

center_v "$(printf "%s\n\n%s\n\n\n%s\n\n%s" \
  "$weather_output" \
  "$greeting_output" \
  "$summary_heading_output" \
  "$summary_output")" "$lines"
