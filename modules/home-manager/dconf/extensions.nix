{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [ ]; 
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "freon@UshakovVasilii_Github.yahoo.com"
          "gsconnect@andyholmes.github.io"
          "solaar-extension@sidevesh"
          "tactile@lundal.io"
        ];
      };
    };
  };
}
