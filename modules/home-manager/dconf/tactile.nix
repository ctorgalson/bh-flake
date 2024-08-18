{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/shell/extensions/tactile" = {
        row-2 = 0;
        grid-cols = 5;
        col-4 = 1;
        layout-2-row-2 = 0;
        layout-2-col-3 = 0;
        layout-2-col-2 = 0;
        monitor-0-layout = 1;
      };
    };
  };
}
