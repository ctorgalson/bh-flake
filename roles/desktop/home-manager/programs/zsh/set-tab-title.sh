#!/usr/bin/env bash

shell_name="$(basename $SHELL)"
git_dir="$(git rev-parse --show-toplevel 2>/dev/null)"

[[ -n "$git_dir" ]] && directory="$git_dir" || directory="$PWD"

echo -ne "\033]0;$(basename "$directory")\007"
