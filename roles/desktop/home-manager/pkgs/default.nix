{ config, pkgs, home, ... }:

{
  imports = [
    ./byobu
    ./claude-code
    ./cli.nix
    ./gbf.nix
    ./glab.nix
    ./gui.nix
    ./nixnvm.nix
    ./opencode
    ./tailscale.nix
    ./timereport.nix
    ./timewarrior
    ./tmux.nix
    ./wakehost.nix
  ];
}
