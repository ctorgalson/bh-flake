{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/desktop/a11y" = {
        always-show-universal-access-status = true;
      };
    };
  };
}
