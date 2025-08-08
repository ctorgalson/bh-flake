#!/usr/bin/env bash

#
# Updates repo remote url and submodule.
#
function updateRepo () {
  # Static variables for remote name and ssh remote url.
  remotename="origin"
  sshremote="git@github.com:ctorgalson/bh-flake.git"

  # Get the actual current remote url.
  currentremote="$(git remote get-url "$remotename")"

  if [[ "$sshremote" != "$currentremote" ]]; then
    # Launch bitwarden.
    bitwarden > /dev/null 2>&1 &

    # Pause while we login.
    echo "Log into Bitwarden and enable SSH agent, then hit Enter... "
    read -rs

    # Update the origin url.
    git remote set-url origin "$sshremote"
  fi

  # Update the whole repo.
  git fetch && git pull origin main

  # Update the sops submodule.
  git submodule update --init --recursive
}

#
# Fetches and writes our SOPS key to the file system.
#
function getSopsKey () {
  # Static variables for secret id from BWS, and path to the SOPS age key.
  secretid="c34b225f-0c4e-42d6-8c2c-b28d0133105f"
  keypath="$HOME/.config/sops/age/keys.txt"

  if [[ ! -f "$keypath" ]]; then
    # Request a BWS access token.
    echo -n "Enter BWS_ACCESS_TOKEN... "
    read -rs bws_access_token

    # Ensure the directory exists.
    mkdir -p "$(dirname "$keypath")"

    # Retrieve the secret.
    secret=$(BWS_ACCESS_TOKEN="$bws_access_token" bws secret get "$secretid")

    # Dump the contents of the secret into a file, and set the file's permissions.
    jq --raw-output .value <<< "$secret" > "$keypath"
    chmod "644" "$keypath"
  fi
}

updateRepo

getSopsKey
