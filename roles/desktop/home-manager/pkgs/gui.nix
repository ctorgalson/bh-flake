{ config, pkgs, home, stable-pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      bitwarden-desktop
      borgbackup
      bruno                       # Open-source IDE For exploring and testing APIs
      # darktable                 # Seems to rely on outdated version of libsoup
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
      stable-pkgs.gpt4all         # Local LLM runner, but pkg is borked
      guvcview
      httpie-desktop              # Cross-platform API testing client for humans.
      libreoffice                 # Office suite
      nerd-fonts.inconsolata
      nerd-fonts.ubuntu-mono
      inkscape-with-extensions
      kdePackages.kruler          # Screen ruler
      localsend
      lorem
      nextcloud-client
      obsidian
      stable-pkgs.protonvpn-gui
      # quickgui
      resources
      signal-desktop-bin
      slack
      solaar
      spideroak                   # Backups (installed temporarily)
      stable-pkgs.calibre
      totem                       # Gnome Videos
      trayscale                  # Unofficial Tailscale GUI
      usbutils
      via
      vlc
      vorta
      # vscode-extensions.catppuccin.catppuccin-vsc
      # vscode-extensions.ms-vscode-remote.remote-ssh
      # vscode
      # vscodium
      # vscode-extensions.ms-vscode-remote.remote-ssh
      xdg-desktop-portal-gnome    # For Zoom screen sharing
      yubioath-flutter
      # yubikey-manager-qt
      # yubikey-personalization-gui
      zeal
    ];
  };
}
