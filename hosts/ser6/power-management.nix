{ config, pkgs, ... }:

{
  # Import shared desktop power management config
  imports = [
    ../../roles/desktop/nixos/hardware/desktop-power-management.nix
  ];

  # Host-specific: Fix USB-C/Thunderbolt display not waking properly from suspend
  # System wakes (screen reader audible) but display stays black until second input
  # This is likely a DisplayPort link training timeout on the USB-C connection
  # References:
  # - https://nyanpasu64.gitlab.io/blog/amdgpu-sleep-wake-hang/
  # - https://forums.linuxmint.com/viewtopic.php?t=390754
  # - https://bbs.archlinux.org/viewtopic.php?id=252777

  systemd.services.force-display-reconnect = {
    description = "Force display reconnection after suspend";
    after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    serviceConfig = {
      Type = "oneshot";
      # Toggle DPMS to force display link renegotiation
      ExecStart = "${pkgs.bash}/bin/bash -c 'export DISPLAY=:0; ${pkgs.xorg.xset}/bin/xset dpms force off; sleep 1; ${pkgs.xorg.xset}/bin/xset dpms force on'";
      User = "ctorgalson";
    };
  };
}
