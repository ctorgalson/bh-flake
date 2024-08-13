{ config, pkgs, home, programs, ... }:

{
  config = {
    programs.neovim = {
      enable = true;
    };
  };
}
