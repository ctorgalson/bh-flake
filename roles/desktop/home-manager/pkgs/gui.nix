{ config, pkgs, home, stable-pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      borgbackup                  # CLI backup manager (why is this HERE?)
      # darktable                 # Seems to rely on outdated version of libsoup
      fragments                   # Bittorrent client
      guvcview                    # Webcam config utility
      ktailctl                    # Unofficial Tailscale GUI (alt to Trayscale)
      nextcloud-client            # Nextcloud desktop app
      # quickgui
      solaar
      spideroak                   # Backups (installed temporarily)
      stable-pkgs.calibre         # Ebook library manager
      # trayscale                   # Unofficial Tailscale GUI
      usbutils
      via                         # Keyboard configurator: not sure if working
      vlc                         # Video player
      vorta                       # Borg Backup GUI
      xdg-desktop-portal-gnome    # For Zoom screen sharing
      yubioath-flutter
      # yubikey-manager-qt
      # yubikey-personalization-gui

      # Browsers / mail clients
      brave                       # chromium-based browser
      google-chrome               # Chrome browser
      thunderbird                 # Email client

      # Chat clients / coms
      localsend                   # Cross-platform "airdrop" app
      protonvpn-gui               # ProtonVPN: appears to be permanently borked
      signal-desktop-bin          # Signal client
      slack                       # Slack client

      # Development tools
      bruno                       # Open-source IDE For exploring & testing APIs
      kdePackages.kruler          # Screen ruler
      lmstudio                    # GUI LLM manager
      resources                   # GUI version of "top" etc
      zeal                        # Documentation browser

      # Fonts
      nerd-fonts.inconsolata      # Enhanced Inconsolata font
      nerd-fonts.overpass         # Enhanced Overpass font
      nerd-fonts.ubuntu-mono      # Enhanced Ubuntu Mono font

      # Gnome programs / extensions
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
      totem                       # Gnome Videos

      # Graphics tools.
      gimp                        # Raser image editor.
      inkscape-with-extensions    # Vector image editor

      # Notes/writing tools
      obsidian                    # Notes app
      libreoffice                 # Office suite
      lorem                       # GUI greeking generator

      # Security
      bitwarden-desktop           # Password manager
    ];
  };
}
