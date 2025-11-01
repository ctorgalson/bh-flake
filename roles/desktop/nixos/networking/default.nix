{ config, lib, ... }:

let
  # Define Wi-Fi networks here
  wifiNetworks = [
    {
      ssid = "Nemo";
      secretKey = "wifi_psk_nemo";
      uuid = "a1b2c3d4-5e6f-4a5b-9c8d-1e2f3a4b5c6d";
    }
    {
      ssid = "wensley";
      secretKey = "wifi_psk_wensley";
      uuid = "d9e1a8f0-3c4d-4b2a-9e7f-1a2b3c4d5e6f";
    }
    {
      ssid = "wensley_EXT";
      secretKey = "wifi_psk_wensley_ext";
      uuid = "e8f2b9c1-4d5e-4c3b-8f6e-2b3c4d5e6f7a";
    }
  ];

  # Generate SOPS secrets configuration
  wifiSecrets = lib.listToAttrs (map (net: {
    name = net.secretKey;
    value = {
      sopsFile = ../../../../sops/secrets.yaml;
      mode = "0600";
      owner = "root";
    };
  }) wifiNetworks);

  # Generate sops templates
  wifiTemplates = lib.listToAttrs (map (net: {
    name = "${net.ssid}.nmconnection";
    value = {
      content = ''
        [connection]
        id=${net.ssid}
        uuid=${net.uuid}
        type=wifi
        autoconnect=false

        [wifi]
        mode=infrastructure
        ssid=${net.ssid}

        [wifi-security]
        key-mgmt=wpa-psk
        psk=''${config.sops.placeholder.${net.secretKey}}

        [ipv4]
        method=auto

        [ipv6]
        method=auto
      '';
      mode = "0600";
      owner = "root";
      group = "root";
    };
  }) wifiNetworks);

  # Generate environment.etc entries
  wifiEtcFiles = lib.listToAttrs (map (net: {
    name = "NetworkManager/system-connections/${net.ssid}.nmconnection";
    value = {
      source = config.sops.templates."${net.ssid}.nmconnection".path;
      mode = "0600";
    };
  }) wifiNetworks);

in
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
  sops.secrets = wifiSecrets;

  # Generate Network Manager connection files with SOPS-managed passwords
  sops.templates = wifiTemplates;

  # Symlink generated files to NetworkManager's directory
  environment.etc = wifiEtcFiles;
}
