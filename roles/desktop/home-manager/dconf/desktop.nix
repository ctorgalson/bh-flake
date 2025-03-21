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

      "org/gnome/desktop/search-providers" = {
        sort-order = [
          "org.gnome.Calculator.desktop"
          "org.gnome.seahorse.Application.desktop"
          "org.gnome.Settings.desktop"
          "org.gnome.Calendar.desktop"
          "org.gnome.Documents.desktop"
          "org.gnome.Nautilus.desktop"
          "org.gnome.Characters.desktop"
          "org.gnome.clocks.desktop"
          "org.gnome.Contacts.desktop"
        ];
      };
    };
  };
}

# /org/gnome/desktop/search-providers/sort-order
#   ['org.gnome.Contacts.desktop', 'org.gnome.Documents.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Calculator.desktop', 'org.gnome.Calendar.desktop', 'org.gnome.Characters.desktop', 'org.gnome.clocks.desktop', 'org.gnome.Settings.desktop', 'org.gnome.seahorse.Application.desktop']
# 
