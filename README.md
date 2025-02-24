# BH Flake

## Initial deployment (kludgy)

- enable flakes in existing nix config if new
- copy this repo (including submodule) to file system
- `cd bh-flake`
- `./get-sops-key`
- `sudo nixos-rebuild switch --flake '#hostname?submodules=1'`

## Subsequent deployments

- `nix flake update`
- `git commit -am 'feat: updates flake.lock'` (if changed)
- `sudo nixos-rebuild switch --flake '.?submodules=1'`
