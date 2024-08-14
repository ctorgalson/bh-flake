{ config, pkgs, programs, ... }:

{
  config = {
    programs.neovim = {
      enable = true;
    };
  };
}
