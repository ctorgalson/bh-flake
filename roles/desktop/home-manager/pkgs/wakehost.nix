{ config, pkgs, home, ... }:

{
  config = {
    home.packages = with pkgs; [
      (writeShellScriptBin "wakehost" ''
        #!/usr/bin/env bash

        if [ $# -eq 0 ]; then
          echo "Usage: wakehost <hostname>"
          echo "Available hosts:"
          echo "  ser6"
          exit 1
        fi

        HOSTNAME="$1"

        # Map hostnames to MAC addresses
        case "$HOSTNAME" in
          ser6)
            MAC_ADDRESS="70:70:fc:05:8c:8d"
            ;;
          *)
            echo "Error: Unknown host '$HOSTNAME'"
            echo "Available hosts: ser6"
            exit 1
            ;;
        esac

        echo "Sending WakeOnLAN packet to $HOSTNAME ($MAC_ADDRESS) via pi0..."
        ssh pi0 "wakeonlan $MAC_ADDRESS"

        if [ $? -eq 0 ]; then
          echo "WakeOnLAN packet sent successfully"
        else
          echo "Failed to send WakeOnLAN packet"
          exit 1
        fi
      '')
    ];
  };
}
