{ config, pkgs, home, stable-pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      bitwarden-desktop           # Password manager
      borgbackup
      bruno                       # Open-source IDE For exploring and testing APIs
      # darktable                 # Seems to rely on outdated version of libsoup
      fragments                   # Bittorrent client
      gimp                        # Raser image editor.
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
      google-chrome               # Chrome browser
      stable-pkgs.gpt4all         # Local LLM runner, but pkg is borked
      guvcview                    # Webcam config utility
      libreoffice                 # Office suite
      nerd-fonts.inconsolata      # Enhanced Inconsolata font
      nerd-fonts.ubuntu-mono      # Enhanced Ubuntu Mono font
      inkscape-with-extensions    # Vector image editor
      kdePackages.kruler          # Screen ruler
      localsend                   # Cross-platform "airdrop" app
      lorem                       # GUI greeking generator
      nextcloud-client            # Nextcloud desktop app
      obsidian                    # Notes app
      stable-pkgs.protonvpn-gui   # ProtonVPN: appears to be permanently borked
      # quickgui
      resources                   # GUI version of "top" etc
      signal-desktop-bin          # Signal client
      slack                       # Slack client
      solaar
      spideroak                   # Backups (installed temporarily)
      stable-pkgs.calibre         # Ebook library manager
      thunderbird                 # Email client
      totem                       # Gnome Videos
      trayscale                   # Unofficial Tailscale GUI
      usbutils
      via                         # Keyboard configurator: not sure if working
      vlc                         # Video player
      vorta                       # Borg Backup GUI
      xdg-desktop-portal-gnome    # For Zoom screen sharing
      yubioath-flutter
      # yubikey-manager-qt
      # yubikey-personalization-gui
      zeal                        # Documentation browser
    ];
  };
}
