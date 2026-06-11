#!/usr/bin/env bash

fzf_args=()
[[ -n "$1" ]] && fzf_args+=(--query "$1")
if command -v fzf &> /dev/null; then
  git branch | (fzf "${fzf_args[@]}") | xargs git checkout
else
  echo "Could not find 'fzf'. Please install it or use the git command directly."
fi

