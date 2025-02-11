{ config, lib, pkgs, programs, ... }:

{
  imports = [
    ./appindicator.nix
    ./clocks.nix
    ./desktop.nix
    ./extensions.nix
    ./fonts.nix
    ./freon.nix
    ./gnome-terminal.nix
    ./gsconnect.nix
    ./settings-daemon.nix
    ./tactile.nix
    ./weather.nix
  ];

  gnome-terminal.enable = true;
}
