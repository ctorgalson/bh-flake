{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      ansible
      bitwarden-cli
      byobu
      clamav
      ddev
      diceware
      diffpdf
      fastfetch
      gcc
      gnome-terminal
      gtop
      hddtemp
      httpie
      imagemagick
      jq
      lm_sensors
      lynis
      nodejs_22
      orpie
      pciutils
      platformsh
      quickemu
      rich-cli
      shellcheck
      timewarrior
      tmux
      tree-sitter
      unison
      wl-copy
      wl-paste
      yq
      yt-dlp
      zip
    ];
  };
}
