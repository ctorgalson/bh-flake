{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      borgbackup
      calibre
      gimp-with-plugins
      gnomeExtensions.appindicator
      gnomeExtensions.freon
      gnomeExtensions.gsconnect
      gnomeExtensions.tactile
      gnome-clocks
      gnome-color-manager
      gnome-extension-manager
      google-chrome
      guvcview
      # pkgs.nerd-fonts.inconsolata
      nerdfonts
      inkscape-with-extensions
      lorem
      nextcloud-client
      obsidian
      protonvpn-gui
      # quickgui
      signal-desktop
      slack
      vorta
      vlc
      vscodium
      yubikey-manager-qt
      yubikey-personalization-gui
      zeal
      zed-editor
    ];
  };
}
