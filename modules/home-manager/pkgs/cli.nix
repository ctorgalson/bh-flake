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
      wl-clipboard
      yq
      yt-dlp
      yubikey-personalization
      zip
    ];
  };
}
