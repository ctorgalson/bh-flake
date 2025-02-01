{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/desktop/calendar" = {
        show-weekdate = true;
      };

      "org/gnome/desktop/datetime" = {
        automatic-timezone = true;
      };

      "org/gnome/desktop/interface" = {
        clock-show-weekday = true;
      };

      "org/gnome/desktop/input-sources" = {
        xk-options = [
          "terminate:ctrl_alt_bksp"
          "lv3:switch"
          "compose:ralt"
        ];
      };
    };
  };
}
