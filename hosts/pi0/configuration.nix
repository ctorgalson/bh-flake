# pi0 configuration - minimal network appliance for WOL
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/ssh.nix
    ../../modules/users.nix
  ];

  # Configure users for pi0 appliance
  bhFlake.users = {
    enableAdmin = true;
    adminPasswordFile = config.sops.secrets.password.path;
    enableDeployment = true;
  };

  # Hostname
  networking.hostName = "pi0";

  # Enable Tailscale
  services.tailscale.enable = true;

  # Configure SOPS secrets
  sops.secrets.age_key = {
    sopsFile = ../../sops/appliance/pi0.yaml;
    path = "/root/.config/sops/age/keys.txt";
    mode = "0600";
  };
  sops.secrets.tailscale_auth_key = {
    sopsFile = ../../sops/appliance/pi0.yaml;
  };
  sops.secrets.password = {
    sopsFile = ../../sops/appliance/pi0.yaml;
    neededForUsers = true;
  };
  sops.secrets.wifi_config = {
    sopsFile = ../../sops/appliance/pi0.yaml;
  };

  # Configure SOPS to use the deployed age key
  # Only enable when not building SD image (chicken-egg problem on first boot)
  sops.age.keyFile = lib.mkIf (!(config.system.build ? sdImage)) config.sops.secrets.age_key.path;

  # Configure Tailscale to use auth key for automatic connection
  # Only enable when not building SD image
  services.tailscale.authKeyFile = lib.mkIf (!(config.system.build ? sdImage)) config.sops.secrets.tailscale_auth_key.path;

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

  # Enable zsh (required since ctorgalson user uses zsh shell)
  programs.zsh.enable = true;

  # Disable unnecessary services
  services.xserver.enable = false;

  # Auto-login on console for bootstrap (only during SD image build)
  # After colmena deploy, this is disabled and password auth is required
  services.getty.autologinUser = lib.mkIf (config.system.build ? sdImage) "ctorgalson";

  # Enable WiFi with wpa_supplicant for bootstrap only
  # After colmena deploy, WiFi is disabled and Tailscale is used exclusively
  networking.wireless = {
    enable = lib.mkIf (config.system.build ? sdImage) true;
    userControlled.enable = true;
    # Include WiFi credentials from temp file during SD image build
    # The build script prompts for credentials and creates /tmp/pi0-wifi.conf
    extraConfig = lib.mkIf (config.system.build ? sdImage) (
      builtins.readFile /tmp/pi0-wifi.conf
    );
  };

  # Enable NetworkManager for ethernet management
  # Configure it to ignore WiFi (managed by wpa_supplicant)
  networking.networkmanager = {
    enable = true;
    unmanaged = [ "wlan0" ];
  };

  # Set timezone
  time.timeZone = "America/Toronto";

  # Basic locale settings
  i18n.defaultLocale = "en_CA.UTF-8";

  # System state version
  system.stateVersion = "25.05";
}
