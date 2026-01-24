{ pkgs, ... }:

{
  # iPhone USB tethering support
  # Enables USB tethering from iPhones for mobile connectivity
  # Useful for laptops on the go and desktops during internet outages

  services.usbmuxd = {
    enable = true;
    # If you experience pairing or connection issues, try switching to usbmuxd2:
    # package = pkgs.usbmuxd2;
  };

  environment.systemPackages = with pkgs; [
    libimobiledevice # iOS device communication library
    ifuse            # Optional: mount iOS filesystem
  ];
}
