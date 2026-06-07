{ config, pkgs, programs, ... }:

{
  config = {
    programs.eza = {
      enable = true;
      enableZshIntegration = true;
      extraOptions = [
        "--group"
      ];
      git = true;
      icons = "auto";
    };
  };
}
