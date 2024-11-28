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
      fd
      ffmpeg
      gcc
      gnome-terminal
      gphoto2
      gtop
      hddtemp
      httpie
      imagemagick
      jq
      # https://superuser.com/questions/1027608/how-to-read-an-acsm-file-on-linux#1775619
      libgourou
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
      unzip
      wl-clipboard
      yq
      yt-dlp
      yubikey-manager
      yubikey-personalization
      zip
    ];
  };
}
