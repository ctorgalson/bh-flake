{ config, pkgs, programs, ... }:

{
  config = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        top = "gtop";
        nvim = "lvim";
        vi = "lvim";
        vim = "lvim";
      };
    };
  };
}
