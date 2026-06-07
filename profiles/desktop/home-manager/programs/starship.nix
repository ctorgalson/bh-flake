{ config, pkgs, programs, ... }:

{
  config = {
    programs.starship = {
      enable = true;
      settings = {};
    };
  };
}
