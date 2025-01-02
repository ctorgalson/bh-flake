{ config, pkgs, programs, ... }:

{
  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        top = "gtop";
        vi = "nvim";
        vim = "nvim";
      };
    };
  };
}
