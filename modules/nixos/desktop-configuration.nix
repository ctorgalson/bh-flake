{ allowed-unfree-packages, inputs, lib, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc = {
    automatic = true;
    dates = "02:00";
    options = "--delete-older-than 3d";
    randomizedDelaySec = "45min";
  };

  networking.networkmanager.enable = true;

  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  services.tailscale = {
    enable = true;
  };

  main-user.enable = true;
  main-user.userName = "ctorgalson";
  main-user.userDescription = "Christopher Torgalson";

  programs.git.enable = true;

  programs.zsh.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages;
  };

  environment.systemPackages = with pkgs; [
    bws
    docker
    micro
    mkcert
    steam
    zoom-us
  ];

  programs.steam.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

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

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "ctorgalson" = import ../../modules/home-manager; 
    };
  };  

  system.autoUpgrade = {
    enable = true;
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
}
