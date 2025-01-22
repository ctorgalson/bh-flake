{ config, pkgs, home, ... }:

{
  imports = [
    ./clamav.nix
    ./syncthing.nix
  ];
}
