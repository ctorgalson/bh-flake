{ config, pkgs, programs, ... }:

{
  config = {
    programs.joplin-desktop = {
      enable = true;
      sync.interval = "10m";
      sync.target = "nextcloud";
    };
  };
}

