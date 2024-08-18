{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "com/raggesilver/BlackBox" = {
        font = "Inconsolata Nerd Font Mono 14";
        theme-bold-is-bright = true;
        theme-dark = "Solarized Dark";
        style-preference = (lib.hm.gvariant.mkUint32 2);
        # $%^&#$%@#& dconf
        #
        #terminal-padding = (lib.hm.gvariant.mkUint32 10) (lib.hm.gvariant.mkUint32 10) (lib.hm.gvariant.mkUint32 10) (lib.hm.gvariant.mkUint32 10);
      };
    };
  };
}
