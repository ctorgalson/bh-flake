{ config, pkgs, home, programs, ... }:

{
  config = {
    programs.atuin = {
      enable = true;
    };
  };
}
