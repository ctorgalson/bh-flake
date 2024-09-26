{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      borgbackup
      calibre
      flameshot
      gimp-with-plugins
      gnome-clocks
      gnomeExtensions.freon
      gnomeExtensions.gsconnect
      gnomeExtensions.tactile
      google-chrome
      inconsolata-nerdfont
      inkscape-with-extensions
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
