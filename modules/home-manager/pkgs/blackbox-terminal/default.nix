{ config, lib, pkgs, home, ... }:

{
  config = {
    # Install package.
    home.packages = with pkgs; [
      blackbox-terminal
    ];

    # Get custom theme for it.
    home.file = {
      ".local/share/blackbox/schemes/catppuccin-mocha.json".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/tilix/refs/heads/main/themes/catppuccin-mocha.json";
        hash = "sha256-CVfkJlhFZUQthVBScDKw7XDplZjLSEyprAbXBOBjyEY=";
      };
    };

    # Configure package preferences.
    dconf.settings = {
      "com/raggesilver/BlackBox" = {
        font = "UbuntuMono Nerd Font Mono 14";
        theme-bold-is-bright = true;
        remember-window-size = true;
        show-headerbar = true;
        floating-controls = true;
        delay-before-showing-floating-controls = (lib.hm.gvariant.mkUint32 250);
        style-preference = (lib.hm.gvariant.mkUint32 2);
        theme-dark = "Catppuccin Mocha";
      };
    };
  };
}
