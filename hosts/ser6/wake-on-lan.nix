{ config, pkgs, ... }:

{
  # Enable Wake-on-LAN for ethernet interface
  networking.interfaces.enp2s0.wakeOnLan.enable = true;

  # Ensure WoL persists after suspend/resume
  systemd.services.enable-wol = {
    description = "Enable Wake-on-LAN after suspend";
    after = [ "network.target" "suspend.target" "hibernate.target" ];
    wantedBy = [ "multi-user.target" "post-resume.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.ethtool}/bin/ethtool -s enp2s0 wol g";
    };
  };
}
