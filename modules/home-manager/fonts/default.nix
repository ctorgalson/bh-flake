{ config, fonts, home, lib, pkgs, ... }:

{
  config = {
    fonts.fontconfig.enable = true;
    home.packages = [
      pkgs.dejavu_fonts
      pkgs.ubuntu-sans
      pkgs.nerd-fonts.DejaVuSansMono  
      pkgs.nerd-fonts.Inconsolata
      pkgs.nerd-fonts.UbuntuMono
      # (pkgs.nerdfonts.override { fonts = [ "Inconsolata" ]; })
    ];
  };
}
