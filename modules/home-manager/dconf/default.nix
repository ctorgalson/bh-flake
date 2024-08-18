{ config, lib, pkgs, programs, ... }:

{
  imports = [
    ./clocks.nix
    ./extensions.nix
    ./freon.nix
    ./gnome-terminal.nix
    ./gsconnect.nix
    ./tactile.nix
    ./weather.nix
  ];

  gnome-terminal.enable = true;
}
