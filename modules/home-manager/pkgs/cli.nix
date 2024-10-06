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
      gnome-terminal
      gtop
      hddtemp
      httpie
      imagemagick
      jq
      lm_sensors
      lynis
      orpie
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
