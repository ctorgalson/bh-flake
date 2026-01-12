{ config, pkgs, home, ... }:

{
  imports = [
    ./byobu
    ./claude-code
    ./cli.nix
    ./gcofzf.nix
    ./glab.nix
    ./gui.nix
    ./nixnvm.nix
    ./opencode
    ./timereport.nix
    ./timewarrior
    ./tmux.nix
    ./wakehost.nix
  ];
}
