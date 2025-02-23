{ allowedUnfreePackages, host, inputs, lib, pkgs, system, ... }:

{
  home-manager.users."ctorgalson".config.dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "Cantarell 10";
      document-font-name = "Cantarell 10";
      monospace-font-name = "Source Code Pro 10";
    };
  };
}
