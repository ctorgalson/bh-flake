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
        extraGroups = [ "docker" "libvirtd" "networkmanager" "wheel" ];
        isNormalUser = true;
        shell = pkgs.zsh;
        hashedPasswordFile = lib.mkIf (cfg.adminPasswordFile != null) cfg.adminPasswordFile;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIARjoOuzp5vkg05GYXcvGSqwH+TPMtEWjWx6AQo+QofY xps13-9350 / 2023-08-07"
        ];
      };
      # Note: wheel group users require password for sudo (standard security)

      # During SD image build, allow passwordless sudo since SOPS password isn't available
      security.sudo.wheelNeedsPassword = lib.mkIf (config.system.build ? sdImage) false;
    })

    # Deployment user configuration
    (lib.mkIf cfg.enableDeployment {
      # Colmena deployment user (authentication via SSH key)
      users.users.bh = {
        description = "Colmena deployment user";
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIARjoOuzp5vkg05GYXcvGSqwH+TPMtEWjWx6AQo+QofY xps13-9350 / 2023-08-07"
        ];
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
