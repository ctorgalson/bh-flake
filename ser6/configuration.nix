# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
#
# Installer version customized per https://github.com/Misterio77/nix-starter-configs
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
  ];
  
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      ctorgalson = import ../home-manager/home.nix;
    };
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-6959cef7-9727-4cab-a672-a440e9e5ff95".device = "/dev/disk/by-uuid/6959cef7-9727-4cab-a672-a440e9e5ff95";
  networking.hostName = "ser6"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # FIXME: Add the rest of your current configuration

  # TODO: Set your hostname
  # networking.hostName = "your-hostname";

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    ctorgalson = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      # initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIARjoOuzp5vkg05GYXcvGSqwH+TPMtEWjWx6AQo+QofY"
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIL8NdyEZwj8stFcSA+y6kXeP2a5reIjtPF5g3E5WkOFcAAAABHNzaDo="
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIDtpZtMLS2NxNgLu+jNA5mufLH2shsKottATkgQZ0DyEAAAABHNzaDo="
        "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDK1/S0Q2E46Pi34Q4a0/o8Y7pljVnpBfNUeLcDk/KPMHKEFwqy1WSo3eBnI8gZtA7r5tNBctFC3FPnDx+oHlmEOz/mBKmQMLyxM1+5cfP6AjpYJ17WZMtt/xdASD4EbYNhGvk1lVaaj4+wTN2gTKiP1tdp8F2kPYjbXVqJv8BstLvloC5dF+XPPdlA0/sEQOGETGzcUywqSqpQ0DDHZbN+3n24UBJWBy6bJnI973wybt3qCaWiEyyqHZxIu1+gY03Y9dH82MdIeqGVv4PsHT5x3ziIvYo/2s0AR9s236sb/fiyd4ok/YSv34F3lyIFC3NM3RtOaGOmckfloUUZp2ed+728N4XMXLOo0JXszjui0/wxyE/jiFXtM8Pmb7npzLWsPjoOwCA7acy6XYuaOl30jmKXYBfobGvfnhTmjPzQvRAZextkG+nJE5R31P0q86BaJx/zY6EOrL1vJ1vCM9eNYMOg57gI5AuRyu/grRBxpEzQp/OU72SAqUCxkqGq/sYZpoBPdIlw/9153WnvodJUpFL8SQLA3+0FDRHOK2y0b24AVqXeRhOxONAFMGwKmTFb3HrkrUSGAFEdk3JS7RNi1bym04irBx/ODPGyFoIicxfa1F8HED7rkklG9XKJXGW6hyK/Pbs5kZhv8ZSgbjD0Grh9ZGmmLr3VTz4ipwO4Gw=="
      ];
      # TODO: Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        # thunderbird
      ];
    };
  };
  
  programs.firefox.enable = true;
  
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     git
     vim
  ];


  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
