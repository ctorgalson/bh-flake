{ config, lib, ... }:

{
  imports = [
    ./wifi-dns.nix
  ];
}

# Original configuration below
// let
  # DDEV projects
  ddevProjects = [
    # Add your project names here, e.g.:
    # "myproject"
    # "anotherproject"
  ];

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

  # Generate sops templates

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
  networking = {
    # Generate /etc/hosts entries for DDEV projects
    extraHosts = lib.concatMapStringsSep "\n"
      (project: "127.0.0.1 ${project}.ddev.site")
      ddevProjects;

    firewall = {
      # SSH firewall rules are in modules/ssh.nix
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

    networkmanager = {
      enable = true;
    };
  };


  # SOPS secrets for Wi-Fi passwords
  # sops.secrets = wifiSecrets;

  # Generate Network Manager connection files with SOPS-managed passwords
  # sops.templates = wifiTemplates;

  # Symlink generated files to NetworkManager's directory
  # environment.etc = wifiEtcFiles;
}
