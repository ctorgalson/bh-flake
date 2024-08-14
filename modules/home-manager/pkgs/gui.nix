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
      gnomeExtensions.gtile
      gpaste
      inconsolata-nerdfont
      inkscape-with-extensions
      joplin-desktop # needed here AND in programs?
      nextcloud-client
      protonvpn-gui
      quickgui
      signal-desktop
      solaar
      vorta
      vscodium
      zeal
    ];
  };
}
