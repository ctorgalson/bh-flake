{ config, pkgs, home, programs, ... }:

{
  config = {
    home.packages = with pkgs; [
      eza
    ];

    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = true;
    };
  };
}
