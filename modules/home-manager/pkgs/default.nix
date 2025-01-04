{ config, pkgs, home, ... }:

{
  imports = [
    ./blackbox-terminal
    ./cli.nix
    ./get-ssh-keys.nix
    ./gui.nix
    ./homefox.nix
    ./nixnvm.nix
    ./workfox.nix
  ];
}
