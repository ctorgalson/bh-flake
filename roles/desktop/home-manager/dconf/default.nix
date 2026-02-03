{ config, lib, pkgs, programs, ... }:

{
  imports = [
    ./accessibility.nix
    ./clocks.nix
    ./desktop.nix
    ./extensions
    # Taken over by stylix
    # ./fonts.nix
    ./freedesktop.nix
    ./gnome-console.nix
    ./gnome-terminal.nix
    ./settings-daemon.nix
    ./weather.nix
  ];

  gnome-terminal.enable = true;
}
