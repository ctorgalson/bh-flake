{ config, host, inputs, lib, pkgs, ... }:

let
  # Helper script to combine scan results into display log
  combineLogs = pkgs.writeShellScriptBin "combine-scan-logs" ''
    full_log="/home/${host.username}/last-clamscan-full.log"
    daily_log="/home/${host.username}/last-clamscan-daily.log"
    display_log="/home/${host.username}/last-clamscan.log"
    temp_file="$(${pkgs.coreutils}/bin/mktemp)"

    # Extract complete summary from full scan (without SCAN SUMMARY header)
    if [ -f "$full_log" ]; then
      echo "-------- LAST FULL SCAN --------" >> "$temp_file"
      ${pkgs.gnused}/bin/sed -n '/^Infected files:/,/^End Date:/p' "$full_log" >> "$temp_file" || true
      echo "" >> "$temp_file"
    fi

    # Extract complete summary from daily scan (without SCAN SUMMARY header)
    if [ -f "$daily_log" ]; then
      echo "-------- LAST DAILY SCAN -------" >> "$temp_file"
      ${pkgs.gnused}/bin/sed -n '/^Infected files:/,/^End Date:/p' "$daily_log" >> "$temp_file" || true
    fi

    # Move to display location
    ${pkgs.coreutils}/bin/mv "$temp_file" "$display_log"
    ${pkgs.coreutils}/bin/chown "${host.username}:users" "$display_log"
  '';

  # Full system scan (weekly)
  avScanFull = pkgs.writeShellScriptBin "av-scan-full" ''
    full_log="/home/${host.username}/last-clamscan-full.log"
    temp_file="$(${pkgs.coreutils}/bin/mktemp)"
    signal_username="$(${pkgs.coreutils}/bin/cat ${config.sops.secrets.signal_username.path})"

    # Run full scan with low priority (nice +19, ionice idle class)
    # --fdpass allows daemon to scan files as root (inherits service permissions)
    # VirusEvent in clamd.conf will handle infection notifications automatically
    ${pkgs.systemd}/bin/systemd-inhibit --what=sleep:handle-lid-switch --who="ClamAV weekly scan" --why="Antivirus weekly scan in progress" \
      ${pkgs.util-linux}/bin/ionice -c 3 ${pkgs.coreutils}/bin/nice -n 19 \
        ${pkgs.clamav}/bin/clamdscan --fdpass --multiscan /home /tmp /var/tmp > "$temp_file" 2>&1 || true

    # Send success notification for completed full scan
    ${pkgs.signal-cli}/bin/signal-cli send --username "$signal_username" \
      -m "✓ ClamAV full scan complete on ${host.hostname}" || true

    # Move results to full log
    ${pkgs.coreutils}/bin/mv "$temp_file" "$full_log"
    ${pkgs.coreutils}/bin/chown "${host.username}:users" "$full_log"

    # Update combined display log
    ${combineLogs}/bin/combine-scan-logs
  '';

  # Script to send Signal notification when virus is detected
  virusNotify = pkgs.writeShellScriptBin "clamav-virus-notify" ''
    # Environment variables provided by clamd:
    # CLAM_VIRUSEVENT_FILENAME - the infected file path
    # CLAM_VIRUSEVENT_VIRUSNAME - the virus/malware name

    signal_username="$(${pkgs.coreutils}/bin/cat ${config.sops.secrets.signal_username.path})"

    ${pkgs.signal-cli}/bin/signal-cli send --username "$signal_username" \
      -m "⚠️ ClamAV ALERT on ${host.hostname}: Infected file detected!
Virus: $CLAM_VIRUSEVENT_VIRUSNAME
File: $CLAM_VIRUSEVENT_FILENAME" || true
  '';

  # Incremental scan (daily) - only files modified in last 24 hours
  avScanDaily = pkgs.writeShellScriptBin "av-scan-daily" ''
    daily_log="/home/${host.username}/last-clamscan-daily.log"
    temp_file="$(${pkgs.coreutils}/bin/mktemp)"
    file_list="$(${pkgs.coreutils}/bin/mktemp)"

    # Find files modified in last 24 hours
    ${pkgs.findutils}/bin/find /home /tmp /var/tmp -type f -mtime -1 2>/dev/null > "$file_list" || true

    # Only scan if we found files
    if [ -s "$file_list" ]; then
      # Run incremental scan with low priority
      # VirusEvent in clamd.conf will handle infection notifications automatically
      ${pkgs.util-linux}/bin/ionice -c 3 ${pkgs.coreutils}/bin/nice -n 19 \
        ${pkgs.clamav}/bin/clamdscan --fdpass --file-list="$file_list" > "$temp_file" 2>&1 || true
    else
      echo "----------- SCAN SUMMARY -----------" > "$temp_file"
      echo "Scanned files: 0" >> "$temp_file"
      echo "Infected files: 0" >> "$temp_file"
      echo "Time: 0.000 sec (0 m 0 s)" >> "$temp_file"
      echo "Start Date: $(${pkgs.coreutils}/bin/date '+%Y:%m:%d %H:%M:%S')" >> "$temp_file"
      echo "" >> "$temp_file"
      echo "No files modified in last 24 hours" >> "$temp_file"
    fi

    # Cleanup
    ${pkgs.coreutils}/bin/rm -f "$file_list"
    ${pkgs.coreutils}/bin/mv "$temp_file" "$daily_log"
    ${pkgs.coreutils}/bin/chown "${host.username}:users" "$daily_log"

    # Update combined display log
    ${combineLogs}/bin/combine-scan-logs
  '';
in
{
  environment.systemPackages = [
    avScanFull
    avScanDaily
    combineLogs
    virusNotify
    pkgs.signal-cli
  ];

  # @see https://mynixos.com/options/services.clamav
  # @see https://linux.die.net/man/5/clamd.conf
  services.clamav = {
    daemon = {
      enable = true;
      settings = {
        LogFile = "/var/log/clamd.log";
        LogTime = true;
        MaxDirectoryRecursion = 50;
        # Execute script when virus is detected (provides CLAM_VIRUSEVENT_* env vars)
        VirusEvent = "${virusNotify}/bin/clamav-virus-notify";
      };
    };
    updater.enable = true;
  };

  # Create log file with proper ownership
  systemd.tmpfiles.rules = [
    "f /var/log/clamd.log 0644 clamav clamav -"
  ];

  # SOPS secret for Signal username
  sops.secrets.signal_username = {
    sopsFile = ../../../../../sops/workstation/shared.yaml;
    owner = "root";
    mode = "0400";
  };

  # Full scan service (weekly)
  systemd.services.av-scan-full = {
    description = "Antivirus Full Scan";
    after = [ "clamav-daemon.service" ];
    requires = [ "clamav-daemon.service" ];
    serviceConfig = {
      ExecStart = "${avScanFull}/bin/av-scan-full";
      Type = "oneshot";
    };
  };

  # Full scan timer (weekly on Mondays)
  systemd.timers.av-scan-full = {
    description = "Run full antivirus scan weekly";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "Mon 08:11:00";
      Persistent = true;  # Run missed scans on next boot/wake
    };
  };

  # Daily scan service (incremental)
  systemd.services.av-scan-daily = {
    description = "Antivirus Daily Incremental Scan";
    after = [ "clamav-daemon.service" ];
    requires = [ "clamav-daemon.service" ];
    serviceConfig = {
      ExecStart = "${avScanDaily}/bin/av-scan-daily";
      Type = "oneshot";
    };
  };

  # Daily scan timer
  systemd.timers.av-scan-daily = {
    description = "Run daily incremental antivirus scan";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;  # Run missed scans on next boot/wake
    };
  };
}
