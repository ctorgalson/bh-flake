{ config, pkgs, home, ... }:

{
  imports = [
    ./cli.nix
    ./get-ssh-keys.nix
    ./gui.nix
    ./homefox.nix
    ./nixnvm.nix
    ./workfox.nix
  ];
}
