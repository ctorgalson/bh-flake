{ config, pkgs, ... }:

{
  # Desktop/Mini PC power management - prioritize responsiveness over power saving

  # Disable aggressive USB autosuspend - allows devices to wake system reliably
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  # Configure device wake capabilities
  # Complex setup: keyboard via monitor USB hub, wireless mouse via Logitech dongle
  services.udev.extraRules = ''
    # Enable wake from USB input devices (mouse, keyboard dongles)
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usbhid", ATTR{power/wakeup}="enabled"

    # Keep USB input devices always on (no autosuspend)
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usbhid", ATTR{power/control}="on"

    # Enable wake from USB hubs (needed for keyboards connected through monitor hubs)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{bDeviceClass}=="09", ATTR{power/wakeup}="enabled"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{bDeviceClass}=="09", ATTR{power/control}="on"

    # Enable wake from Bluetooth HID devices (keyboards, mice)
    ACTION=="add", SUBSYSTEM=="bluetooth", ATTR{power/wakeup}="enabled"
    ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", ATTRS{id/bustype}=="0005", ATTR{power/wakeup}="enabled"
  '';

  # Bluetooth power settings
  hardware.bluetooth.powerOnBoot = true;

  # Let GNOME handle power management - logind stays out of the way
  # GNOME Settings Daemon blocks these keys via inhibitor and handles them itself
  services.logind.settings = {
    Login = {
      HandlePowerKey = "ignore";
      HandleSuspendKey = "ignore";
      HandleLidSwitch = "ignore";
      # Don't set IdleAction - let GNOME power settings control screen blanking/suspend
    };
  };

  # Disable power-profiles-daemon to avoid conflicts with GNOME power management
  services.power-profiles-daemon.enable = false;

  # CPU governor - balanced mode for efficiency while still responsive
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";  # Modern balanced scheduler-based governor
  };
}
