{ config, pkgs, programs, ... }:

{
  config = {
    programs.atuin = {
      enable = true;
    };
  };
}
