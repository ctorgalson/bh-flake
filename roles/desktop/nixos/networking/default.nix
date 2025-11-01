{ config, ... }:

{
  networking.firewall = {
    allowedTCPPorts = [
      80
      443
      3000
      4747
      53317 # localsend
    ];

    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];

    allowedUDPPorts = [
      53317 # localsend
    ];

    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  networking.networkmanager.enable = true;

  # SOPS secrets for Wi-Fi passwords
  sops.secrets.wifi_psk_wensley = {
    sopsFile = ../../../../sops/secrets.yaml;
    mode = "0600";
    owner = "root";
  };

  sops.secrets.wifi_psk_wensley_ext = {
    sopsFile = ../../../../sops/secrets.yaml;
    mode = "0600";
    owner = "root";
  };

  # Generate Network Manager connection files with SOPS-managed passwords
  sops.templates."wensley.nmconnection" = {
    content = ''
      [connection]
      id=wensley
      uuid=d9e1a8f0-3c4d-4b2a-9e7f-1a2b3c4d5e6f
      type=wifi
      autoconnect=false

      [wifi]
      mode=infrastructure
      ssid=wensley

      [wifi-security]
      key-mgmt=wpa-psk
      psk=${config.sops.placeholder.wifi_psk_wensley}

      [ipv4]
      method=auto

      [ipv6]
      method=auto
    '';
    path = "/etc/NetworkManager/system-connections/wensley.nmconnection";
    mode = "0600";
    owner = "root";
    group = "root";
  };

  sops.templates."wensley_EXT.nmconnection" = {
    content = ''
      [connection]
      id=wensley_EXT
      uuid=e8f2b9c1-4d5e-4c3b-8f6e-2b3c4d5e6f7a
      type=wifi
      autoconnect=false

      [wifi]
      mode=infrastructure
      ssid=wensley_EXT

      [wifi-security]
      key-mgmt=wpa-psk
      psk=${config.sops.placeholder.wifi_psk_wensley_ext}

      [ipv4]
      method=auto

      [ipv6]
      method=auto
    '';
    path = "/etc/NetworkManager/system-connections/wensley_EXT.nmconnection";
    mode = "0600";
    owner = "root";
    group = "root";
  };
}
