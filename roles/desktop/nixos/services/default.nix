{ inputs, lib, pkgs, ... }:

{
  # @see https://mynixos.com/options/services.clamav
  # @see https://linux.die.net/man/5/clamd.conf
  # @see https://linux.die.net/man/5/freshclam.conf
  services.clamav = {
    daemon = {
      enable = true;
      settings = {
        LogSyslog = true;
        MaxDirectoryRecursion = 50;
      };
    };

    fangfrisch = {
      enable = false;
    };

    scanner = {
      enable = true;
      interval = "*-*-* 15:20:00";
    };

    updater = {
      enable = true;
    };
  };

  services.fwupd = {
    enable = true;
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

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };
}
