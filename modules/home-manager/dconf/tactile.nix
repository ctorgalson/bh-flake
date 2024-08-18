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

        background-color = "rgba(0,0,0,0.75)";
        border-color = "rgba(255,255,255,0.666667)";
        text-color = "rgba(0,0,0,1)";
      };
    };
  };
}

# /org/gtk/gtk4/settings/color-chooser/selected-color
#   (true, 0.0, 0.0, 0.0, 0.74666666984558105)
# 
# /org/gnome/shell/extensions/tactile/background-color
#   'rgba(0,0,0,0.746667)'
# /org/gtk/gtk4/settings/color-chooser/custom-colors
#   [(0.0, 0.0, 0.0, 0.74666666984558105), (0.0, 0.0, 0.0, 0.73000001907348633), (0.0, 0.0, 0.0, 0.56999999284744263), (0.0, 0.0, 0.0, 0.46000000834465027), (1.0, 1.0, 1.0, 0.63333332538604736), (1.0, 1.0, 1.0, 0.45333334803581238), (1.0, 1.0, 1.0, 0.64666664600372314), (0.50196081399917603, 0.50196081399917603, 1.0, 0.10000000149011612)]
# 
# /org/gtk/gtk4/settings/color-chooser/selected-color
#   (true, 1.0, 1.0, 1.0, 0.67333334684371948)
# 
# /org/gnome/shell/extensions/tactile/border-color
#   'rgba(255,255,255,0.673333)'
# /org/gtk/gtk4/settings/color-chooser/custom-colors
#   [(1.0, 1.0, 1.0, 0.67333334684371948), (1.0, 1.0, 1.0, 0.5), (0.0, 0.0, 0.0, 0.5), (0.0, 0.77999973297119141, 1.0, 0.5), (0.50196081399917603, 0.50196081399917603, 1.0, 0.5), (0.50196081399917603, 0.50196081399917603, 1.0, 1.0), (1.0, 1.0, 1.0, 0.63333332538604736), (1.0, 1.0, 1.0, 0.45333334803581238)]
# 
# /org/gtk/gtk4/settings/color-chooser/selected-color
#   (true, 1.0, 1.0, 1.0, 0.96666663885116577)
# 
# /org/gnome/shell/extensions/tactile/text-color
#   'rgba(255,255,255,0.966667)'
# /org/gtk/gtk4/settings/color-chooser/custom-colors
#   [(1.0, 1.0, 1.0, 0.96666663885116577), (0.50196081399917603, 0.50196081399917603, 1.0, 1.0), (1.0, 1.0, 1.0, 0.63333332538604736), (1.0, 1.0, 1.0, 0.45333334803581238), (1.0, 1.0, 1.0, 0.64666664600372314), (0.50196081399917603, 0.50196081399917603, 1.0, 0.10000000149011612)]
