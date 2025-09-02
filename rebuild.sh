#!/usr/bin/env bash

# Runs e.g. nixos-rebuild switch --flake '.?submodules=1' --show-trace
#
# All parts of the command after `switch` are configurable with cli flags.

if ! command -v getopt &> /dev/null; then
  echo "Error: getopt command was not found."
  echo
  echo "This script requires getopt for argument parsing. Please install it or run the nixos-rebuild command manually."
fi

OPTS=$(getopt -o cf:n:sth --long command-only,flake:,hostname:,submodules,show-trace,help -n "$0" -- "$@")

if [[ $? -ne 0 ]]; then
  echo "Failed to parse options"
  exit 1
fi

eval set -- "$OPTS"

commandonly=false
flake="."
hostname=""
submodules=""
showtrace=""

while true; do
  case $1 in
    -c|--command-only)
      commandonly=true
      shift
      ;;
    -f|--flake)
      flake="$2"
      shift 2
      ;;
    -n|--hostname)
      hostname="#$2"
      shift 2
      ;;
    -s|--submodules)
      submodules="?submodules=1"
      shift
      ;;
    -t|--show-trace)
      showtrace=true
      shift
      ;;
    -h|--help)
      echo
      echo "Usage: $0 [OPTIONS]"
      echo
      echo "This is a simple wrapper around nixos-rebuild that constructs the argument for"
      echo "the --flake parameter, and optionally uses --show-trace."
      echo
      echo "In most circumstances, ./rebuild.sh will do."
      echo
      echo "  -c, --command-only Echo a generated command only"
      echo "                     Use to display command syntax rather than running the command"
      echo
      echo "  -f, --flake        Specify the path for the flake to use"
      echo "                     Use when not running the script from inside the flake directory"
      echo
      echo "  -n, --hostname     Specify hostname for flake to use"
      echo "                     Use on first-run, or when changing machine hostname"
      echo
      echo "  -s, --submodules   Add ?submodules=1 to nixos-rebuild command"
      echo "                     Use when the flake includes submodules, but doesn't set "
      echo "                     \`inputs.self.submodules = true\`"
      echo
      echo "  -t, --show-trace   Add --show-trace to nixos-rebuild command"
      echo "                     Use when experiencing errors"
      echo
      echo "  -h, --help         Show this help message"
      echo "                     Use when confused :)"
      exit 0
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Some kind of parsing error happened, sorry."
      exit 1
      ;;
  esac
done

flakeparam="${flake}${submodules}${hostname}"

if [[ "$commandonly" == true ]]; then
  echo "sudo --preserve-env=SSH_AUTH_SOCK nixos-rebuild switch --flake \"${flakeparam}\" ${showtrace:+--show-trace}"
else
  sudo --preserve-env=SSH_AUTH_SOCK nixos-rebuild switch --flake "${flakeparam}" ${showtrace:+--show-trace}
fi
