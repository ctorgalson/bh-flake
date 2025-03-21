{ config, lib, pkgs, programs, ... }:

{
  imports = [
    ./appindicator.nix
    ./clocks.nix
    ./desktop.nix
    ./extensions.nix
    # Taken over by stylix
    # ./fonts.nix
    ./freon.nix
    ./freedesktop.nix
    ./gnome-terminal.nix
    ./gsconnect.nix
    ./settings-daemon.nix
    ./tactile.nix
    ./weather.nix
  ];

  gnome-terminal.enable = true;
}
