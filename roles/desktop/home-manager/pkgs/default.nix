{ config, pkgs, home, ... }:

{
  imports = [
    ./byobu
    ./cli.nix
    ./gcofzf.nix
    ./gui.nix
    ./homefox.nix
    ./nixnvm.nix
    ./opencode
    ./timereport.nix
    ./timewarrior
    ./workfox.nix
  ];
}
