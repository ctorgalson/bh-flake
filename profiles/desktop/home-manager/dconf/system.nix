{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/system/location" = {
        enabled = true;
      };
    };
  };
}
