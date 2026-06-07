{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
      };
    };
  };
}

