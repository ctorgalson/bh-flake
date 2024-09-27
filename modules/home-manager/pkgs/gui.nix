{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      borgbackup
      calibre
      flameshot
      gimp-with-plugins
      gnomeExtensions.freon
      gnomeExtensions.gsconnect
      gnomeExtensions.tactile
      gnome-clocks
      gnome-extensions-manager
      google-chrome
      inconsolata-nerdfont
      inkscape-with-extensions
      lorem
      nextcloud-client
      protonvpn-gui
      #quickgui
      signal-desktop
      slack
      solaar
      vorta
      vscodium
      zeal
    ];
  };
}
