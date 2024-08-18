{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [ ]; 
        enabled-extensions = [
          "freon@UshakovVasilii_Github.yahoo.com"
          "gsconnect@andyholmes.github.io"
          "tactile@lundal.io"
        ];
      };
    };
  };
}
