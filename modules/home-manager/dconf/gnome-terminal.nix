{ config, lib, pkgs, programs, ... }:

{
  options = {
    gnome-terminal.enable = lib.mkEnableOption "enable gnome-terminal module";  

    gnome-terminal.profileId = lib.mkOption {
      default = "b1dcc9dd-5262-4d8d-a863-c897e6d979b9";
      description = ''
        profile id
      '';
    };
  };

  config = {
    dconf.settings = {
      "org/gnome/terminal/legacy" = {
        theme-variant = "dark";
      };
      "org/gnome/terminal/legacy/profiles:/:${config.gnome-terminal.profileId}" = {
        use-system-font = false;
        font = "UbuntuMono Nerd Font 14";
        use-theme-colors = false;
        foreground-color = "rgb(131,148,150)";
        background-color = "rgb(0,43,54)";
        palette = [
          "rgb(7,54,66)"
          "rgb(220,50,47)"
          "rgb(133,153,0)"
          "rgb(181,137,0)"
          "rgb(38,139,210)"
          "rgb(211,54,130)"
          "rgb(42,161,152)"
          "rgb(238,232,213)"
          "rgb(0,43,54)"
          "rgb(203,75,22)"
          "rgb(88,110,117)"
          "rgb(101,123,131)"
          "rgb(131,148,150)"
          "rgb(108,113,196)"
          "rgb(147,161,161)"
          "rgb(253,246,227)"
        ];
        bold-is-bright = true;
      };
    };
  };
}

# /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-system-font
#   false
# 
# /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font
#   'Inconsolata Nerd Font Mono 14'
# 
# /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/use-theme-colors
#   false
# 
# /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/foreground-color
#   'rgb(131,148,150)'
# 
# /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/background-color
#   'rgb(0,43,54)'
# 
# /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/palette
#   ['rgb(7,54,66)', 'rgb(220,50,47)', 'rgb(133,153,0)', 'rgb(181,137,0)', 'rgb(38,139,210)', 'rgb(211,54,130)', 'rgb(42,161,152)', 'rgb(238,232,213)', 'rgb(0,43,54)', 'rgb(203,75,22)', 'rgb(88,110,117)', 'rgb(101,123,131)', 'rgb(131,148,150)', 'rgb(108,113,196)', 'rgb(147,161,161)', 'rgb(253,246,227)']
# 
# /org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/bold-is-bright
#   true
# 
# /org/gnome/terminal/legacy/theme-variant
#   'dark'
# 
