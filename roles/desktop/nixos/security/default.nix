{ inputs, lib, pkgs, ... }:

{
  security.rtkit.enable = true;

  # Limited passwordless sudo for Colmena deployment user
  security.sudo.extraRules = [
    {
      users = [ "bh" ];
      commands = [
        {
          command = "/nix/store/*/bin/switch-to-configuration";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/nix/store/*/activate";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/nix-env";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
