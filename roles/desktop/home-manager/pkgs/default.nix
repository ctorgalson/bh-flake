{ config, pkgs, home, ... }:

{
  imports = [
    ./byobu
    ./claude-code
    ./cli.nix
    ./gcofzf.nix
    ./gui.nix
    ./homefox.nix
    ./nixnvm.nix
    ./opencode
    ./timereport.nix
    ./timewarrior
    ./tmux.nix
    ./wakehost.nix
    ./workfox.nix
  ];
}
