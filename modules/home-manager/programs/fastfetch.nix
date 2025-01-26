{ config, pkgs, programs, ... }:

{
  config = {
    programs.fastfetch = {
      enable = true;
    };
  };
}
