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
      glow
      gnome-terminal
      gtop
      hddtemp
      httpie
      imagemagick
      jq
      # https://superuser.com/questions/1027608/how-to-read-an-acsm-file-on-linux#1775619
      #
      # # Use your username and password from https://account.adobe.com
      # This registers your device so only needs to be done once.
      # adept_activate -u user -p pass
      #
      # Download the ACSM file
      # acsmdownloader -f myfile.acsm
      #
      # Decrypt
      # adept_remove file.pdf
      libgourou
      lm_sensors
      lynis
      nodejs_22
      orpie
      pciutils
      platformsh
      python314
      #quickemu
      rich-cli
      shellcheck
      sqlite
      timewarrior
      # tmux
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
