{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      bitwarden-cli
      blackbox-terminal
      byobu
      ddev
      diceware
      diffpdf
      fastfetch
      gtop
      hddtemp
      httpie
      imagemagick
      jq
      lm_sensors
      lynis
      pciutils
      platformsh
      quickemu
      shellcheck
      tmux
      yt-dlp
    ];
  };
}
