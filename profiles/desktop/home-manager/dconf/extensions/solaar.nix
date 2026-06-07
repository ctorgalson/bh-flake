{ pkgs, ... }:

{
  config = {
    home.packages = with pkgs; [
      gnomeExtensions.solaar-extension
    ];

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [
          "solaar-extension@sidevesh"
        ];
      };
    };
  };
}
