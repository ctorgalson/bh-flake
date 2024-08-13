{ config, pkgs, home, programs, ... }:

{
  config = {
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
