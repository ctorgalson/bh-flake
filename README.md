# BH Flake

## Initial deployment (kludgy)

- install via installer
- enable flakes in existing nix config if new
- `git clone https://github.com/ctorgalson/bh-flake.git`
- `nix-shell`
- `sudo nixos-rebuild switch --flake '#hostname?submodules=1'`

## Subsequent deployments

- `nix flake update`
- `git commit -am 'feat: updates flake.lock'` (if changed)
- `sudo nixos-rebuild switch --flake '.?submodules=1'`
