{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      atuin
      bitwarden-cli
      bws
      byobu
      ddev
      diceware
      docker
      fastfetch
      gtop
      httpie
      imagemagick
      jq
      lynis
      platformsh
      starship
      tmux
    ];
  };
}
