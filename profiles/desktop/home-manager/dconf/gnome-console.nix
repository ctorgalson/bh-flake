{ config, lib, pkgs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/Console" = {
        use-system-font = false;
        custom-font = "InconsolataNFM-Regular 16";
      };
    };
  };
}
