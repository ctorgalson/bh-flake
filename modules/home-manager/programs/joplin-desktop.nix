{ config, pkgs, programs, ... }:

{
  config = {
    programs.joplin-desktop = {
      enable = true;
    };
  };
}

