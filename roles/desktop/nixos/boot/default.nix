{ pkgs, lib, ... }:

{
  boot = {
    # Enable systemd in initrd (required for Plymouth with LUKS)
    initrd.systemd.enable = lib.mkDefault true;

    # Quiet boot for clean Plymouth display
    consoleLogLevel = lib.mkDefault 3;
    initrd.verbose = lib.mkDefault false;
    kernelParams = lib.mkDefault [ "quiet" "splash" ];

    plymouth = {
      enable = lib.mkDefault true;
      theme = lib.mkDefault "catppuccin-mocha";
      themePackages = lib.mkDefault [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
      logo = ../../../../images/nixos-square.png;
      # HiDPI scaling for high resolution displays (200%)
      extraConfig = lib.mkDefault ''
        [Daemon]
        DeviceScale=2
      '';
    };
  };
}
