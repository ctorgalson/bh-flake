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

  networking.wireless = {
    enable = true;
    environmentFile = config.sops.secrets.wifi_config.path;
    networks = {
      "wensley".pskRaw = "ext:PSK_WENSLEY";
      "wensley_EXT".pskRaw = "ext:PSK_WENSLEY_EXT";
    };
  };
}
