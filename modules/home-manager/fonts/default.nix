{ config, fonts, home, lib, pkgs, ... }:

{
  config = {
    fonts.fontconfig.enable = true;
    fonts.packages = with pkgs; [
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.inconsolata
      nerd-fonts.ubuntu-mono
      zpix-pixel-font
    ];
    # home.packages = [
    #   # pkgs.dejavu_fonts
    #   # pkgs.ubuntu-sans
    #   # https://mynixos.com/nixpkgs/packages/nerd-fonts
    #   pkgs.nerd-fonts.dejavu-sans-mono
    #   pkgs.nerd-fonts.inconsolata
    #   pkgs.nerd-fonts.ubuntu-mono
    # ];
  };
}
