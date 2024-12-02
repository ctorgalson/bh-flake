{ config, fonts, home, lib, pkgs, ... }:

{
  config = {
    fonts.fontconfig.enable = true;
    home.packages = [
      pkgs.nerd-fonts.inconsolata
      # (pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; })
    ];
  };
}
