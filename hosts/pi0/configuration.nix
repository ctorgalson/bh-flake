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

  # Enable mDNS for .local hostname discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      workstation = true;
    };
  };

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
    ncurses  # Includes common terminal definitions
    # Use ether-wake from net-tools (cross-compiles better than wol)
    nettools
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

      ${pkgs.nettools}/bin/ether-wake "$MAC"
      echo "Sent WOL packet to $HOST ($MAC)"
    '')
  ];


  # Enable zsh with basic functionality
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    # Vim-style key bindings and proper terminal support
    interactiveShellInit = ''
      # Vim key bindings
      bindkey -v

      # Fix common key bindings that should work in both modes
      bindkey "^[[3~" delete-char        # Delete
      bindkey "^[[H" beginning-of-line   # Home
      bindkey "^[[F" end-of-line         # End
      bindkey "^?" backward-delete-char  # Backspace

      # History search with vim bindings
      bindkey "^[[A" history-search-backward  # Up arrow
      bindkey "^[[B" history-search-forward   # Down arrow
    '';

    # Basic prompt
    promptInit = ''
      autoload -U colors && colors
      PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%# '
    '';
  };

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

  # Disable USB autosuspend for ethernet adapter (prevents disconnections)
  # The Waveshare ETH/USB HAT uses RTL8152B chip which can go to sleep
  services.udev.extraRules = ''
    # Disable autosuspend for Realtek USB ethernet (Waveshare HAT)
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="r8152", ATTR{power/autosuspend}="-1"
  '';

  # Keep CPU governor at performance to prevent power-saving issues
  powerManagement.cpuFreqGovernor = lib.mkForce "performance";

  # Set timezone
  time.timeZone = "America/Toronto";

  # Basic locale settings
  i18n.defaultLocale = "en_CA.UTF-8";

  # zRAM swap (Pi Zero 2 W only has 512MB RAM)
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  # System state version
  system.stateVersion = "25.05";
}
