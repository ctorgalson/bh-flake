{ ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
      };

      "org/gnome/shell/extensions/appindicator" = {
      };
    };
  };
}
