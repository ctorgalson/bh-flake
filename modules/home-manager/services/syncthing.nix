{ config, pkgs, programs, services, ... }:

{
  config = {
    services.syncthing = {
      enable = true; 
      # @see https://nix-community.github.io/home-manager/options.xhtml#opt-services.syncthing.settings
      settings = {
        devices = {
          executive14 = {
            addresses = [ "tcp://100.70.30.43" ];
            id = "P5S4BLK-LG6SGIL-MYYBQFY-RULRMZI-CW3DRJT-47YEQCK-YS35BWR-JNYQUQV";
            name = "Executive 14";
          };
          framework13 = {
            addresses = [ "100.72.220.20" ];
            id = "5FD4APM-6GOYMMY-UQEQWXA-JTS6QYA-Y4NSCIS-SVAXP5N-XZ5ZFR4-U2UJFAD";
            name = "Framework 13";
          };
          # ser6 = {
          #   addresses = [ "100.74.137.33" ];
          #   id = "";
          #   name = "ser6";
          # };
        };
        folders = {
          "/home/ctorgalson/Storage/Documents" = {
            id = "documents";
            devices = [ "executive14" "framework13" ];
            label = "Documents";
            type = "sendrecieve";
            versioning = {
              type = "trashcan";
              params.cleanoutDays = "500";
            };
          };
        };
        options = {
          urAccepted = -1;
        };
      };
      tray = {
        enable = true;
      };
    };
  };
}
