{ config, pkgs, home, ... }:

{
  imports = [
    ./byobu
    ./claude-code
    ./cli.nix
    ./glab.nix
    ./gui.nix
    ./nixnvm.nix
    ./opencode
    ./scripts.nix
    ./tailscale.nix
    ./timereport.nix
    ./timewarrior
    ./tmux
    ./wakehost.nix
  ];
}
