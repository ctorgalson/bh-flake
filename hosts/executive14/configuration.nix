# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ allowed-unfree-packages, config, inputs, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/nixos/main-user.nix
    ];

  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable garbage-collection.
  nix.gc = {
    automatic = true;
    dates = "02:00";
    options = "--delete-older-than 3d";
    randomizedDelaySec = "45min";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-0c5bd87e-16c8-4d5a-9ed3-4212402e8789".device = "/dev/disk/by-uuid/0c5bd87e-16c8-4d5a-9ed3-4212402e8789";
  networking.hostName = "executive14"; # Define your hostname.
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

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_CA.UTF-8";
    LC_IDENTIFICATION = "en_CA.UTF-8";
    LC_MEASUREMENT = "en_CA.UTF-8";
    LC_MONETARY = "en_CA.UTF-8";
    LC_NAME = "en_CA.UTF-8";
    LC_NUMERIC = "en_CA.UTF-8";
    LC_PAPER = "en_CA.UTF-8";
    LC_TELEPHONE = "en_CA.UTF-8";
    LC_TIME = "en_CA.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable bluetooth.
  hardware.bluetooth.enable = true;

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

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  services.tailscale = {
    enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  #users.users.ctorgalson = {
  #  isNormalUser = true;
  #  description = "Christopher Torgalson";
  #  extraGroups = [ "networkmanager" "wheel" ];
  #  packages = with pkgs; [
  #  #  thunderbird
  #  ];
  #};
  main-user.enable = true;
  main-user.userName = "ctorgalson";
  main-user.userDescription = "Christopher Torgalson";

  # Install git.
  programs.git.enable = true;

  # Install firefox.
  # programs.firefox.enable = true;

  # Install zsh.
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
    bws
    docker
    micro
    mkcert
    steam
    zoom-us
    #vim
  ];

  programs.steam.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall = {
    allowedTCPPorts = [
      80
      443
      3000
    ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPorts = [ ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Home-manager.
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ctorgalson" = import ./home.nix;
    };
  };

  # Enable autoUpgrade.
  system.autoUpgrade = {
    enable = true;

    allowReboot = true;
    dates = "02:00";
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    randomizedDelaySec = "45min";
  };

  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
