{ config, fonts, home, lib, pkgs, ... }:

{
  config = {
    fonts.fontconfig.enable = true;
    home.packages = [
      pkgs.dejavu_fonts
      pkgs.nerd-fonts.inconsolata
      pkgs.nerd-fonts.ubuntu
      # (pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; })
    ];
  };
}
