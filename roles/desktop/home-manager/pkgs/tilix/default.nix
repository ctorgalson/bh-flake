{ config, lib, pkgs, ... }:

{
  options = {
    tilix-terminal.profileId = lib.mkOption {
      default = "2b7c4080-0ddd-46c5-8f23-563fd3ba789d";
      description = ''
        profile id
      '';
    };
  };

  config = {
    home.packages = with pkgs; [
      tilix
    ];

    home.file = {
      ".config/tilix/schemes/catppuccin-mocha.json".source = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/tilix/refs/heads/main/themes/catppuccin-mocha.json";
        hash = "sha256-CVfkJlhFZUQthVBScDKw7XDplZjLSEyprAbXBOBjyEY=";
      };
    };

    dconf.settings = {
      "com/gexperts/Tilix" = {
        terminal-title-show-when-single = false;
        terminal-title-style = "none";
        theme-variant = "dark";
        window-style = "borderless";
      };
      "com/gexperts/Tilix/profiles/${config.tilix-terminal.profileId}" = {
        background-color = "#1E1E2E";
        foreground-color = "#CDD6F4";
        palette = [
          "#BAC2DE"
          "#F38BA8"
          "#A6E3A1"
          "#F9E2AF"
          "#89B4FA"
          "#F5C2E7"
          "#94E2D5"
          "#585B70"
          "#A6ADC8"
          "#F38BA8"
          "#A6E3A1"
          "#F9E2AF"
          "#89B4FA"
          "#F5C2E7"
          "#94E2D5"
          "#45475A"
        ];
        use-theme-colors = false;
        use-system-font = false;
        font = "UbuntuMono Nerd Font Mono 15";
      };
    };
  };
}
