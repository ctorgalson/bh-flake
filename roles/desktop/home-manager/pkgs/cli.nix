{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      age
      ansible
      bitwarden-cli
      # clamav
      ddev
      diceware
      diffpdf
      fd
      ffmpeg
      figlet
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
      #
      # adept_activate -u user -p pass
      #
      # Download the ACSM file
      # acsmdownloader -f myfile.acsm
      #
      # Decrypt
      # adept_remove file.pdf
      lazygit
      libgourou
      lm_sensors
      lynis
      nixos-icons
      nodejs_22
      orpie
      pciutils
      platformsh
      plymouth
      python314
      #quickemu
      rich-cli
      shellcheck
      sops
      sqlite
      # timewarrior
      # tmux
      tree
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
