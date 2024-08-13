{ config, pkgs, home, programs, ... }:

{
  config = {
    home.packages = with pkgs; [
      starship
    ];

    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {};
    };
  };
}
