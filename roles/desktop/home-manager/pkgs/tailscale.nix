{ config, pkgs, ... }:

{
  # Tailscale packages
  home.packages = with pkgs; [
    tailscale   # Tailscale CLI
    trayscale   # Unofficial Tailscale GUI
  ];

  # Create a desktop entry that launches trayscale with pkexec (polkit)
  # This prompts for password via GUI and runs trayscale as root
  xdg.desktopEntries.trayscale-sudo = {
    name = "Trayscale (Admin)";
    genericName = "Tailscale System Tray (Root)";
    comment = "Unofficial Tailscale system tray application with elevated privileges";
    exec = "pkexec env DISPLAY=''$DISPLAY XAUTHORITY=''$XAUTHORITY XDG_RUNTIME_DIR=''$XDG_RUNTIME_DIR HOME=''$HOME ${pkgs.trayscale}/bin/trayscale";
    icon = "trayscale";
    terminal = false;
    type = "Application";
    categories = [ "Network" ];
  };
}
