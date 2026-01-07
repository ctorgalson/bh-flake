{ lib, pkgs, ... }:

{
  # Enable SSH server restricted to local networks only
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = lib.mkDefault "no";

      # Timeout inactive SSH sessions after 15 minutes
      # Sends keepalive every 5 minutes, disconnects after 3 failed attempts
      ClientAliveInterval = 300;
      ClientAliveCountMax = 3;
    };
  };

  # Firewall: Allow SSH only from private networks (RFC 1918)
  networking.firewall = {
    enable = lib.mkDefault true;
    extraCommands = ''
      iptables -A nixos-fw -p tcp --dport 22 -s 192.168.0.0/16 -j nixos-fw-accept
      iptables -A nixos-fw -p tcp --dport 22 -s 10.0.0.0/8 -j nixos-fw-accept
      iptables -A nixos-fw -p tcp --dport 22 -s 172.16.0.0/12 -j nixos-fw-accept
      iptables -A nixos-fw -p tcp --dport 22 -j nixos-fw-log-refuse
    '';
  };

  # Prevent system suspension when active SSH sessions exist
  systemd.services.ssh-suspend-inhibitor = {
    description = "Prevent suspend when SSH sessions are active";
    wantedBy = [ "multi-user.target" ];
    after = [ "sshd.service" ];

    serviceConfig = {
      Type = "simple";
      Restart = "always";
      RestartSec = "10s";
      ExecStart = pkgs.writeShellScript "ssh-suspend-inhibitor" ''
        while true; do
          # Check if any SSH sessions exist
          if ${pkgs.procps}/bin/pgrep -x sshd > /dev/null && \
             [ "$(${pkgs.coreutils}/bin/who | ${pkgs.gnugrep}/bin/grep -c pts)" -gt 0 ]; then
            # Active SSH sessions found - hold inhibitor lock for 15 minutes
            ${pkgs.systemd}/bin/systemd-inhibit \
              --what=sleep \
              --who="SSH Session Guard" \
              --why="Active SSH sessions present" \
              --mode=block \
              ${pkgs.coreutils}/bin/sleep 900
          else
            # No sessions - sleep without inhibitor
            ${pkgs.coreutils}/bin/sleep 600
          fi
        done
      '';
    };
  };
}
