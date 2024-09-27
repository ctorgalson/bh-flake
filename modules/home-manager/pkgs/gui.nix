{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      borgbackup
      calibre
      flameshot
      gimp-with-plugins
      gnomeExtensions.appindicator
      gnomeExtensions.freon
      gnomeExtensions.gsconnect
      gnomeExtensions.tactile
      gnome-clocks
      gnome-extension-manager
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
