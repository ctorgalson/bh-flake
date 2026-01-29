{ pkgs, ... }:

{
  # Tailscale packages
  home.packages = with pkgs; [
    tailscale         # Tailscale CLI
    tailscale-systray # Official Tailscale GUI
  ];
}
