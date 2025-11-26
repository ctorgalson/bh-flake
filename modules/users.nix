{ lib, config, pkgs, ... }:

let
  cfg = config.bhFlake.users;
in
{
  options.bhFlake.users = {
    enableAdmin = lib.mkEnableOption "administrative user (ctorgalson)";

    adminPasswordFile = lib.mkOption {
      type = lib.types.nullOr lib.types.path;
      default = null;
      description = "Path to file containing hashed password for admin user (for headless systems)";
    };

    enableDeployment = lib.mkEnableOption "deployment user (bh)";
  };

  config = lib.mkMerge [
    # Administrative user configuration
    (lib.mkIf cfg.enableAdmin {
      users.users.ctorgalson = {
        description = "Christopher";
        extraGroups = [ "docker" "networkmanager" "wheel" ];
        isNormalUser = true;
        shell = pkgs.zsh;
        hashedPasswordFile = lib.mkIf (cfg.adminPasswordFile != null) cfg.adminPasswordFile;
      };
      # Note: wheel group users require password for sudo (standard security)
    })

    # Deployment user configuration
    (lib.mkIf cfg.enableDeployment {
      # Colmena deployment user (authentication via Tailscale SSH)
      users.users.bh = {
        description = "Colmena deployment user";
        isNormalUser = true;
        # Note: bh is NOT in wheel group - only has limited passwordless sudo for deployment
      };

      # Limited passwordless sudo for deployment user (only specific deployment commands)
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
    })
  ];
}
