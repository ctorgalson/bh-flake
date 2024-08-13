{ config, pkgs, home, programs, ... }:

{
  config = {
    home.packages = with pkgs; [
      zsh
    ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        top = "gtop";
        vim = "nvim";
      };
    };
  };
}
