# pi0 configuration - minimal network appliance for WOL
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/users.nix
  ];

  # Configure users for pi0 appliance
  bhFlake.users = {
    enableAdmin = true;
    adminPasswordFile = config.sops.secrets.password_pi0.path;
    enableDeployment = true;
  };

  # Hostname
  networking.hostName = "pi0";

  # Enable Tailscale
  services.tailscale.enable = true;

  # Configure SOPS secrets
  sops.secrets.tailscale_pi0 = {
    sopsFile = ../../sops/secrets.yaml;
  };
  sops.secrets.password_pi0 = {
    sopsFile = ../../sops/secrets.yaml;
  };

  # Configure Tailscale to use auth key for automatic connection
  services.tailscale.authKeyFile = config.sops.secrets.tailscale_pi0.path;

  # Auto-update system from flake (TODO: fix to use github URL)
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "03:00";
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    randomizedDelaySec = "45min";
  };

  # Install Wake-on-LAN package and custom wake script
  environment.systemPackages = with pkgs; [
    vim
    htop
    curl
    wol
    (pkgs.writeScriptBin "wake" ''
      #!/usr/bin/env bash

      case "$1" in
        ser6)
          MAC="70:70:fc:05:8c:8d"
          HOST="ser6"
          ;;
        *)
          echo "Unknown host: $1"
          echo "Available hosts: ser6"
          exit 1
          ;;
      esac

      ${pkgs.wol}/bin/wol "$MAC"
      echo "Sent WOL packet to $HOST ($MAC)"
    '')
  ];

  # Disable unnecessary services
  services.xserver.enable = false;
  sound.enable = false;

  # Enable networking (NetworkManager instead of wireless)
  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkForce false;

  # Set timezone
  time.timeZone = "America/Toronto";

  # Basic locale settings
  i18n.defaultLocale = "en_CA.UTF-8";

  # System state version
  system.stateVersion = "25.05";
}
