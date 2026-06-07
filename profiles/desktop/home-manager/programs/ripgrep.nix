{ config, pkgs, programs, ... }:

{
  config = {
    programs.ripgrep = {
      enable = true;
    };
  };
}
