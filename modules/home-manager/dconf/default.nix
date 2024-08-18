{ config, lib, pkgs, programs, ... }:

{
  imports = [
    ./clocks.nix
    ./console.nix
    ./extensions.nix
    ./freon.nix
    ./gsconnect.nix
    ./tactile.nix
    ./weather.nix
  ];
}
