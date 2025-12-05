# { inputs, lib, pkgs, ... }:

{
  imports = [
    ./clamav
  ];

  services.fwupd = {
    enable = true;
  };

  services.journald.extraConfig = ''
    SystemMaxUse=500M
    MaxRetentionSec=7d
  '';

  # OpenSSH server configuration is in the common ssh module (imported via role)

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.ollama = {
    enable = true;
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "10m"; # Unload models after 10 minutes of inactivity.
    };
    loadModels = [
      "qwen2.5-coder:3b"
    ];
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  systemd.services.tailscaled.wantedBy = [ "multi-user.target" ];

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # GDM HiDPI scaling configuration
  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}"
  ];
}
