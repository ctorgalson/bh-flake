{ config, pkgs, home, ... }:

{
  imports = [
    ./byobu
    ./cli.nix
    ./get-ssh-keys.nix
    ./gui.nix
    ./homefox.nix
    ./nixnvm.nix
    ./timereport.nix
    ./timewarrior
    ./workfox.nix
    ./zellij
  ];
}
