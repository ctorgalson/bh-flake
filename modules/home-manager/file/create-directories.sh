#/usr/bin/env bash

dirs=( 'Dev/BH' 'Dev/AT' 'Nextcloud' )

for dir in "${!dirs[@]}"; do
  path="$HOME/$dir"
  if [ ! -d "$path" ]; then
    echo "Create $path"
    if [ -z "$DRY_RUN" ]; then
      mkdir -p "$path"
    fi
  fi
done
