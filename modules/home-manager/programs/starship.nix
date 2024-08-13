{ config, pkgs, home, programs, ... }:

{
  config = {
    programs.starship = {
      enable = true;
      settings = {};
    };
  };
}
