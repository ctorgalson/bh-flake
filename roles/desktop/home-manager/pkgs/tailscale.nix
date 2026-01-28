{ config, pkgs, ... }:

let
  # Create a wrapper script that properly passes environment variables
  trayscale-sudo = pkgs.writeShellScriptBin "trayscale-sudo" ''
    exec ${pkgs.polkit}/bin/pkexec env \
      DISPLAY="$DISPLAY" \
      XAUTHORITY="$XAUTHORITY" \
      XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
      HOME="$HOME" \
      ${pkgs.trayscale}/bin/trayscale "$@"
  '';
in
{
  # Tailscale packages
  home.packages = with pkgs; [
    tailscale         # Tailscale CLI
    trayscale         # Unofficial Tailscale GUI
    trayscale-sudo    # Trayscale with sudo wrapper
  ];

  # Create a desktop entry that launches trayscale with pkexec (polkit)
  # This prompts for password via GUI and runs trayscale as root
  xdg.desktopEntries.trayscale-sudo = {
    name = "Trayscale (Admin)";
    genericName = "Tailscale System Tray (Root)";
    comment = "Unofficial Tailscale system tray application with elevated privileges";
    exec = "${trayscale-sudo}/bin/trayscale-sudo";
    icon = "trayscale";
    terminal = false;
    type = "Application";
    categories = [ "Network" ];
  };
}
