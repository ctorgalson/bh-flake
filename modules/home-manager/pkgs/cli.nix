{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      atuin
      bitwarden-cli
      # bws
      byobu
      ddev
      diceware
      docker
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
