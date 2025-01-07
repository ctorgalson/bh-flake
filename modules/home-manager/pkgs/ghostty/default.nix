{ config, lib, pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      ghostty
    ];

    home.file.".config/ghostty/config".source = ./dotfiles/config;
  };
}
