{ allowed-unfree-packages, inputs, lib, pkgs, ... }:

{
  imports = [
    ./main-user.nix
    ./services
  ];

  # Vars for main-user module

  main-user.enable = true;
  main-user.userName = "ctorgalson";
  main-user.userDescription = "Christopher Torgalson";

  # NIX

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = true;
    dates = "02:00";
    options = "--delete-older-than 3d";
    randomizedDelaySec = "45min";
  };

  # ENVIRONMENT 

  environment.systemPackages = with pkgs; [
    bws
    docker
    micro
    mkcert
    steam
    zoom-us
  ];

  # I18N

  i18n.defaultLocale = "en_CA.UTF-8";

  # NETWORKING

  networking.firewall = {
    allowedTCPPorts = [
      80
      443
      3000
      4747
      53317 # localsend
    ];

    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];

    allowedUDPPorts = [
      53317 # localsend
    ];

    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  networking.networkmanager.enable = true;

  # NIXPKGS

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
  };

  # PROGRAMS

  programs.git.enable = true;

  programs.steam.enable = true;

  programs.zsh.enable = true;

  # SECURITY

  security.rtkit.enable = true;

  # SERVICES

  # @see modules/home-manager/services
  # @see modules/nixos/services

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;

  services.tailscale = {
    enable = true;
  };

  # SYSTEM

  system.autoUpgrade = {
    enable = true;
    dates = "08:35";
    flake = inputs.self.outPath;
    flags = [
      "--no-write-lock-file"
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    # randomizedDelaySec = "45min";
  };

  # TIME

  time.timeZone = "America/Toronto";

  # VIRTUALISATION

  virtualisation.docker.enable = true;
}
