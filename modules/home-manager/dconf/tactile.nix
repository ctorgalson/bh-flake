{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/shell/extensions/tactile" = {
        grid-cols = 7;
        grid-rows = 4;

        # Layout 1.
        col-0 = 1;
        col-1 = 1;
        col-2 = 1;
        col-3 = 1;
        col-4 = 0;
        col-5 = 0;
        col-6 = 0;
        row-0 = 1;
        row-1 = 1;
        row-2 = 0;
        row-3 = 0;

        # Layout 2.
        layout-2-col-0 = 1;
        layout-2-col-1 = 1;
        layout-2-col-2 = 1;
        layout-2-col-3 = 1;
        layout-2-col-4 = 1;
        layout-2-col-5 = 1;
        layout-2-col-6 = 1;
        layout-2-row-0 = 1;
        layout-2-row-1 = 1;
        layout-2-row-2 = 1;
        layout-2-row-3 = 1;

        # Row 1.
        tile-0-0 = "1";
        tile-1-0 = "2";
        tile-2-0 = "3";
        tile-3-0 = "4";
        tile-4-0 = "5";
        tile-5-0 = "6";
        tile-6-0 = "7";

        # Row 2.
        tile-0-1 = "q";
        tile-1-1 = "w";
        tile-2-1 = "e";
        tile-3-1 = "r";
        tile-4-1 = "t";
        tile-5-1 = "y";
        tile-6-1 = "u";

        # Row 3.
        tile-0-2 = "a";
        tile-1-2 = "s";
        tile-2-2 = "d";
        tile-3-2 = "f";
        tile-4-2 = "g";
        tile-5-2 = "h";
        tile-6-2 = "j";

        # Row 4.
        tile-0-3 = "z";
        tile-1-3 = "x";
        tile-2-3 = "c";
        tile-3-3 = "v";
        tile-4-3 = "b";
        tile-5-3 = "n";
        tile-6-3 = "m";
        
        # Layout keyboard shortcuts.
        layout-1 = "F1";
        layout-2 = "F2";
        layout-3 = "F3";
        layout-4 = "F4";
        
        # Various.
        monitor-0-layout = 1;
        background-color = "rgba(255,255,255,0.666667)";
        border-color = "rgba(0,0,0,0.333333)";
        text-color = "rgba(0,0,0,0.75)";
        show-tiles = [
          "<Super>Return"
        ];
      };
    };
  };
}

# /org/gnome/shell/extensions/tactile/layout-2-row-2
#   1
# /org/gnome/shell/extensions/tactile/grid-cols
#   7
# /org/gnome/shell/extensions/tactile/layout-2-col-6
#   1
# /org/gnome/shell/extensions/tactile/tile-6-0
#   ['y']
# /org/gnome/shell/extensions/tactile/tile-6-1
#   ['u']
# /org/gnome/shell/extensions/tactile/tile-6-2
#   ['j']
# /org/gnome/shell/extensions/tactile/tile-6-3
#   ['m']
# /org/gnome/shell/extensions/tactile/monitor-0-layout
#   4
# /org/gnome/shell/extensions/tactile/monitor-0-layout
#   2
