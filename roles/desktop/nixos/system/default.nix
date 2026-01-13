{ inputs, lib, pkgs, ... }:

{
  # Enable ARM emulation for cross-compilation to pi0
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    flake = inputs.self.outPath;
    flags = [
      "--no-write-lock-file"
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    randomizedDelaySec = "45min";
  };

  # Limit resources for auto-upgrade and add notifications to prevent system lockup
  # https://www.freedesktop.org/software/systemd/man/systemd.resource-control.html
  systemd.services.nixos-upgrade = {
    preStart = ''
      # Notify user that upgrade is starting
      for user in $(${pkgs.coreutils}/bin/users); do
        DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(${pkgs.coreutils}/bin/id -u $user)/bus" \
          ${pkgs.su}/bin/su $user -c "${pkgs.libnotify}/bin/notify-send --urgency=normal 'NixOS Auto-Upgrade' 'System upgrade starting. This may take a while and use significant resources.'" || true
      done
    '';
    postStop = ''
      # Notify user when upgrade completes (success or failure)
      status="$SERVICE_RESULT"
      if [ "$status" = "success" ]; then
        message="System upgrade completed successfully."
        urgency="normal"
      else
        message="System upgrade failed or was stopped. Check logs with: journalctl -u nixos-upgrade"
        urgency="critical"
      fi

      for user in $(${pkgs.coreutils}/bin/users); do
        DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(${pkgs.coreutils}/bin/id -u $user)/bus" \
          ${pkgs.su}/bin/su $user -c "${pkgs.libnotify}/bin/notify-send --urgency=$urgency 'NixOS Auto-Upgrade' '$message'" || true
      done
    '';
    serviceConfig = {
      # Limit memory usage to 50% of system RAM (16GB on 32GB system)
      MemoryMax = "50%";
      # Start swapping at 40% to give warning before hitting limit
      MemoryHigh = "40%";

      # Limit CPU usage to prevent system unresponsiveness
      # CPUQuota: 400% means use max 4 CPU cores worth of compute
      CPUQuota = "400%";

      # Lower priority so interactive processes stay responsive
      Nice = 19;
      IOSchedulingClass = "idle";

      # Kill the service if it exceeds memory limit
      OOMPolicy = "stop";
    };
  };

  # Also limit nix-daemon builder processes
  nix.daemonIOSchedClass = "idle";
  nix.daemonCPUSchedPolicy = "idle";
}
