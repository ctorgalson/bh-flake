{ config, pkgs, home, ... }:

{
  imports = [
    ./blackbox-terminal
    ./byobu
    ./cli.nix
    ./get-ssh-keys.nix
    ./ghostty
    ./gui.nix
    ./homefox.nix
    ./nixnvm.nix
    ./workfox.nix
  ];
}
