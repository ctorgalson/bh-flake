{ config, pkgs, home, programs, ... }:

{
  config = {
    home.packages = with pkgs; [
      atuin
    ];

    programs.atuin = {
      enable = true;
    };
  };
}
