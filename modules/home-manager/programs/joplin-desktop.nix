{ config, pkgs, programs, ... }:

{
  config = {
    programs.joplin-desktop = {
      enable = true;
      extraConfig = { };
      sync.interval = "10m";
      sync.target = "nextcloud";
    };
  };
}

