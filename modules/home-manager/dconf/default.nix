{ config, lib, pkgs, programs, ... }:

{
  imports = [
    ./blackbox.nix
    ./clocks.nix
    ./console.nix
    ./extensions.nix
    ./freon.nix
    ./gsconnect.nix
    ./tactile.nix
    ./weather.nix
  ];
}
