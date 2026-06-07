{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      timewarrior
    ];

    home.file = {
      ".config/timewarrior/timewarrior.cfg".source = ./timewarrior.cfg;
      ".config/timewarrior/themes/catppuccin.theme".source = ./themes/catppuccin.theme;
    };
  };
}
