{ lib, config, pkgs, ... }:

{
  options = {
    main-user.enable =  lib.mkEnableOption "enable user module";

    main-user.userName = lib.mkOption {
      default = "ctorgalson";
      description = ''
        username
      '';
    };

    main-user.description = lib.mkOption {
      default = "Christopher";
      description = ''
        full name
      '';
    };
  };

  config = lib.mkIf config.main-user.enable {
    users.users.${config.main-user.userName} = {
      isNormalUser = true;
      description = ${config.main-user.description};
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
  };
}
