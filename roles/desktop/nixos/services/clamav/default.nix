{ host, inputs, lib, pkgs, ... }:

let
  avScan = pkgs.writeShellScriptBin "av-scan" ''
    user_log="/home/${host.username}/last-clamscan.log"
    temp_file="$(mktemp)"

    # Run scan using daemon (efficient, definitions stay loaded in memory).
    # Output goes to temp file, including the SCAN SUMMARY.
    # Prevent system suspend during the multi-hour scan.
    systemd-inhibit --what=sleep:handle-lid-switch --who="ClamAV scan" --why="Antivirus scan in progress" \
      clamdscan --multiscan /home /tmp /var/tmp > "$temp_file" 2>&1 || true

    # Move results to user log for display in terminal.
    mv "$temp_file" "$user_log"
    chown "${host.username}:users" "$user_log"
  '';
in
{
  environment.systemPackages = [ avScan ];

  # @see https://mynixos.com/options/services.clamav
  # @see https://linux.die.net/man/5/clamd.conf
  services.clamav = {
    daemon = {
      enable = true;
      settings = {
        LogFile = "/var/log/clamd.log";
        LogTime = true;
        MaxDirectoryRecursion = 50;
      };
    };
    updater.enable = true;
  };

  # Define the ClamAV scan service
  systemd.services.av-scan = {
    description = "Antivirus Scan";
    after = [ "clamav-daemon.service" ];
    requires = [ "clamav-daemon.service" ];
    serviceConfig = {
      ExecStart = "${avScan}/bin/av-scan";
      Type = "oneshot";
    };
  };

  # Define the timer for the ClamAV scan
  systemd.timers.av-scan = {
    description = "Run av-scan every other weekday";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "Mon,Wed,Fri 09:31:00";
      Persistent = true;  # Run missed scans on next boot/wake
    };
  };
}
