{ lib, ... }:

{
  # Enable SSH server restricted to local networks only
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = lib.mkDefault "no";
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
}
