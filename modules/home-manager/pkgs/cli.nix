{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      bitwarden-cli
      byobu
      ddev
      diceware
      diffpdf
      fastfetch
      gnome-terminal
      gtop
      hddtemp
      httpie
      imagemagick
      jq
      lm_sensors
      lorem
      lynis
      pciutils
      platformsh
      quickemu
      rich-cli
      shellcheck
      timewarrior
      tmux
      yq
      yt-dlp
      zip
    ];
  };
}
