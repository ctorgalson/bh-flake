{ ... }:

{
  # Captive portal support for laptops
  # Enables automatic detection and authentication with captive portals
  # commonly found in coffee shops, hotels, airports, etc.

  networking = {
    firewall = {
      allowedUDPPorts = [
        53 # DNS - required for captive portal detection
      ];

      allowedTCPPorts = [
        53 # DNS over TCP
      ];

      # Allows asymmetric routing (common with captive portals)
      checkReversePath = "loose";
    };

    networkmanager = {
      settings = {
        connectivity = {
          enabled = true;
          uri = "http://nmcheck.gnome.org/check_network_status.txt";
          interval = 300;
        };
      };
    };
  };
}
