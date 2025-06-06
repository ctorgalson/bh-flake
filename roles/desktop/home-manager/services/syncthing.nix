{ config, pkgs, programs, services, ... }:

{
  config =
  let
    homedir = "/home/ctorgalson";
  in
  {
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
            addresses = [ "tcp://100.72.220.20" ];
            id = "5FD4APM-6GOYMMY-UQEQWXA-JTS6QYA-Y4NSCIS-SVAXP5N-XZ5ZFR4-U2UJFAD";
            name = "Framework 13";
          };
          ser6 = {
            addresses = [ "tcp://100.74.137.33" ];
            id = "ZSMEGAM-DLTNL6D-ECH3ATT-GDR3NIR-N5XJTPO-BA7VW5Q-6JAJELD-MDPOIAK";
            name = "SER6";
          };
        };
        folders = {
          "${homedir}/Storage/Documents" = {
            id = "documents";
            devices = [ "executive14" "framework13" "ser6" ];
            label = "Documents";
            type = "sendreceive";
            versioning = {
              type = "trashcan";
              params.cleanoutDays = "500";
            };
          };
          "${homedir}/.local/share/timewarrior" = {
            id = "timewarrior";
            devices = [ "executive14" "framework13" "ser6" ];
            label = "Timewarrior";
            type = "sendreceive";
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
    };
  };
}
