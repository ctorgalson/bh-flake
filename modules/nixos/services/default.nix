{ config, pkgs, home, ... }:

{
  imports = [
    ./clamav.nix
  ];
}
