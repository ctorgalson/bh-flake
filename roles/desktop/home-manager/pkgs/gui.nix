{ config, pkgs, home, stable-pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      bitwarden-desktop
      borgbackup
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
      stable-pkgs.gpt4all                   # Local LLM runner, but pkg is borked
      guvcview
      libreoffice                 # Office suite
      nerd-fonts.inconsolata
      nerd-fonts.ubuntu-mono
      inkscape-with-extensions
      localsend
      lorem
      nextcloud-client
      obsidian
      stable-pkgs.protonvpn-gui
      # quickgui
      resources
      shutter                     # screenshot and annotation tool
      signal-desktop-bin
      slack
      solaar
      stable-pkgs.calibre
      usbutils
      via
      vlc
      vorta
      # vscode-extensions.catppuccin.catppuccin-vsc
      # vscode-extensions.ms-vscode-remote.remote-ssh
      # vscode
      # vscodium
      # vscode-extensions.ms-vscode-remote.remote-ssh
      yubioath-flutter
      #yubikey-manager-qt
      yubikey-personalization-gui
      zeal
    ];
  };
}
