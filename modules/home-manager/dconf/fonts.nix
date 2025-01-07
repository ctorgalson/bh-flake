{ config, lib, pkgs, programs, ... }:

{
  config = {
    dconf.settings = {
      "org/gnome/desktop/interface" = {
        font-name = "Cantarell 10";
        document-font-name = "Cantarell 10";
      };
    };
  };
}
