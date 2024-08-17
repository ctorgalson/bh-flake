{ config, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/Console" = {
        use-system-font = false;
      };

      custom-font = "'Inconsolata Nerd Font Mono 13'";
    };
  };
}
