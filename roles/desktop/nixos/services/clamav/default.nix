{ inputs, lib, pkgs, ... }:

{
  # @see https://mynixos.com/options/services.clamav
  # @see https://linux.die.net/man/5/clamd.conf
  # @see https://linux.die.net/man/5/freshclam.conf
  services.clamav = {
    daemon = {
      enable = true;
      settings = {
        LogFile = /var/log/clamav.log
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
      # TEMPORARY
      scanDirectories = [ "/home" ];
    };

    updater = {
      enable = true;
    };
  };
}
