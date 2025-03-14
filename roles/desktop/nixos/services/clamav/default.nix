{ host, inputs, lib, pkgs, ... }:

let
  avScan = pkgs.writeShellScriptBin "av-scan" ''
    # Configure vars.
    log_file="/var/log/clamav.log"
    max_cvd_age=3
    #clamscan_targets=("/etc" "/home" "/tmp" "/var/lib" "/var/tmp")
    clamscan_targets=("/home/ctorgalson/bh-flake/")
    user_log="/home/${host.username}/last-clamscan.log"

    # Ensure logfile existence.
    if [ ! -f $user_log ]; then
      touch "$user_log"
      chown "${host.username}:users" "$user_log"
    fi

    # Run scan.
    ${pkgs.clamav}/bin/clamscan \
      --fail-if-cvd-older-than="$max_cvd_age" \
      --infected \
      --log="/var/log/clamav.log" \
      --recursive=yes \
      "''${clamscan_targets[@]}" > "$user_log"
  '';
in
{
  # Write the av-scan script that runs clamav. Include bash as a suspenders and
  # belt strategy.
  environment.systemPackages = with pkgs; [
    avScan
    bash
    # services.clamav must provide this, but ${pkgs.clamav} in the script above
    # doesn't work, so let's install it manually and just make use of the clamav
    # updater service below.
    clamav 
  ];

  # @see https://mynixos.com/options/services.clamav
  # @see https://linux.die.net/man/5/clamd.conf
  # @see https://linux.die.net/man/5/freshclam.conf
  services.clamav = {
    # The daemon and scanner don't make it easy enough to do what we want: a
    # file containing the last clamav summary, updated daily. So we use the
    # updater, but we'll define our own av scanning services.

    # daemon = {
    #   enable = true;
    #   settings = {
    #     LogFile = "/var/log/clamav.log";
    #     LogSyslog = true;
    #     MaxDirectoryRecursion = 50;
    #   };
    # };
    daemon.enable = false;
    fangfrisch.enable = false;
    scanner.enable = false;
    updater.enable = true;
  };

  # Define the ClamAV scan service
  systemd.services.av-scan = {
    description = "Antivirus Scan";
    after = [ "network.target" ];
    wants = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${avScan}/bin/av-scan"; # Use the script created above
      Type = "oneshot";
      RemainAfterExit = true;
      # Prevent sleep while the script is running
      ExecStartPre = "systemd-inhibit --what=handle-lid-switch:sleep --mode=block true";
      # Environment = "SYSTEMD_LOG_LEVEL=debug";
    };
  };

  # Define the timer for the ClamAV scan
  systemd.timers.av-scan = {
    description = "Run av-scan every other weekday";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "Mon,Wed,Fri 08:11:00";
      Persistent = false;
    };
  };

  # Ensure the logfile exists.
  systemd.tmpfiles.settings = {
    "clamav" = {
      "/var/log/clamav.log" = {
        f = {
          group = "clamav";
          mode = "0664";
          user = "root";
        };
      };
    };
  };
}
