{ config, pkgs, home, ... }:

{
  imports = [
    ./byobu
    ./cli.nix
    ./get-ssh-keys.nix
    ./gui.nix
    ./homefox.nix
    ./nixnvm.nix
    ./tilix
    ./timereport.nix
    ./workfox.nix
    ./zellij
  ];
}
