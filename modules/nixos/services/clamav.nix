{ config, pkgs, programs, services, ... }:

# @see https://mynixos.com/options/services.clamav
# @see https://linux.die.net/man/5/clamd.conf
# @see https://linux.die.net/man/5/freshclam.conf
{
  config = {
    services.clamav = {
      daemon= {
        enable = true;
        settings = {
          LogSyslog = true;
          MaxDirectoryRecursion = 50;
        };
      };

      fangfrisch = {
        enable = true;
      };

      scanner = {
        enable = true;
        interval = "*-*-* 09:50:00";
      };

      updater = {
        enable = true;
      };
    };
  };
}
