{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/shell/extensions/gsconnect" = {
        id = "99dcb71d-b661-4153-a616-14a6e29493a5";
        name = "ser6";
      };
    };
  };
}
