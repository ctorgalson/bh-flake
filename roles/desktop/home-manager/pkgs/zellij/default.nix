{ config, lib, pkgs, ... }:

{
  config = {
    # Install package.
    home.packages = with pkgs; [
      zellij
    ];

    # Write dotfile.
    home.file = {
      ".config/zellij/config.kdl".source = ./config.kdl;
    };
  };
}
