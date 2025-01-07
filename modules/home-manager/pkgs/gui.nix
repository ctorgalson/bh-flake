{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      borgbackup
      calibre
      darktable
      fragments
      gimp
      # gimp-with-plugins
      gnomeExtensions.appindicator
      gnomeExtensions.freon
      gnomeExtensions.gsconnect
      gnomeExtensions.solaar-extension
      gnomeExtensions.tactile
      gnome-clocks
      gnome-color-manager
      gnome-multi-writer
      gnome-tweaks
      # gnome-extension-manager
      google-chrome
      guvcview
      nerd-fonts.inconsolata
      nerd-fonts.ubuntu-mono
      # pkgs.nerd-fonts.inconsolata
      # nerdfonts
      # inconsolata-nerdfont
      inkscape-with-extensions
      localsend
      lorem
      nextcloud-client
      obsidian
      protonvpn-gui
      # quickgui
      signal-desktop
      slack
      solaar
      vorta
      vlc
      vscodium
      yubikey-manager-qt
      yubikey-personalization-gui
      zeal
    ];
  };
}
