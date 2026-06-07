{ config, lib, pkgs, ... }:

{
  # NetworkManager dispatcher script to set DNS for specific WiFi networks
  # This overrides ISP DNS settings that can't be changed at the modem level
  #
  # DNS Configuration:
  # - IPv4: Quad9 (9.9.9.9, 149.112.112.112) + Cloudflare (1.1.1.1, 1.0.0.1)
  # - IPv6: Quad9 (2620:fe::fe, 2620:fe::9) + Cloudflare (2606:4700:4700::1111, 2606:4700:4700::1001)

  networking.networkmanager.dispatcherScripts = [
    {
      source = pkgs.writeText "wifi-dns-override" ''
        #!/bin/sh
        # NetworkManager dispatcher script for setting DNS per-network
        # Called with: interface-name action

        INTERFACE=$1
        ACTION=$2

        # Only run on WiFi up events
        if [ "$ACTION" != "up" ] && [ "$ACTION" != "dhcp4-change" ] && [ "$ACTION" != "dhcp6-change" ]; then
            exit 0
        fi

        # Get the connection UUID and SSID
        CONNECTION_UUID="$CONNECTION_UUID"
        SSID="$CONNECTION_ID"

        # Define DNS servers for specific networks
        case "$SSID" in
            "Nemo"|"wensley"|"Wensley")
                # Override ISP DNS with Quad9 + Cloudflare
                IPV4_DNS="9.9.9.9,149.112.112.112,1.1.1.1,1.0.0.1"
                IPV6_DNS="2620:fe::fe,2620:fe::9,2606:4700:4700::1111,2606:4700:4700::1001"

                ${pkgs.networkmanager}/bin/nmcli connection modify "$CONNECTION_UUID" \
                    ipv4.dns "$IPV4_DNS" \
                    ipv4.ignore-auto-dns yes \
                    ipv6.dns "$IPV6_DNS" \
                    ipv6.ignore-auto-dns yes

                # Reapply connection to use new DNS immediately
                ${pkgs.networkmanager}/bin/nmcli device reapply "$INTERFACE"
                ;;
            *)
                # For other networks, don't override DNS
                exit 0
                ;;
        esac
      '';
      type = "basic";
    }
  ];
}
