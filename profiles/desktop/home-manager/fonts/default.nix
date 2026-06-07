{ pkgs, ... }:

{
  config = {
    fonts.fontconfig.enable = true;
    # fonts.packages = with pkgs; [
    #   nerd-fonts.dejavu-sans-mono
    #   nerd-fonts.inconsolata
    #   nerd-fonts.overpass
    #   nerd-fonts.ubuntu-mono
    #   zpix-pixel-font
    # ];
    home.packages = with pkgs; [
      # pkgs.dejavu_fonts
      # pkgs.ubuntu-sans
      # https://mynixos.com/nixpkgs/packages/nerd-fonts
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.inconsolata
      nerd-fonts.overpass
      nerd-fonts.ubuntu-mono
      zpix-pixel-font
    ];
  };
}
