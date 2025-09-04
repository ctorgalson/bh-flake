#!/usr/bin/env bash

cat -n | fzf \
  --preview "echo {1} | xargs -I {} awk \"NR>=({}-3) && NR<=({+3}) {print}\" <<< \"\$(cat)\"" \
  --preview-window=up:40%:border:rounded \
  --no-sort --no-multi --exact --ansi --reverse
