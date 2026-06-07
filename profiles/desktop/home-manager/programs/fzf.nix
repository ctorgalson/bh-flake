{ config, pkgs, programs, ... }:

{
  config = {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
