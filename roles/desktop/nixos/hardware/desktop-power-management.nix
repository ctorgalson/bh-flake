{ config, pkgs, ... }:

{
  # Desktop/Mini PC power management - prioritize responsiveness over power saving

  # Disable aggressive USB autosuspend - allows devices to wake system reliably
  boot.kernelParams = [ "usbcore.autosuspend=-1" ];

  # Configure device wake capabilities
  services.udev.extraRules = ''
    # Enable wake from USB input devices (mouse, keyboard)
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usbhid", ATTR{power/wakeup}="enabled"

    # Keep USB input devices always on (no autosuspend)
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usbhid", ATTR{power/control}="on"

    # Enable wake from Bluetooth devices
    ACTION=="add", SUBSYSTEM=="bluetooth", ATTR{power/wakeup}="enabled"
  '';

  # Bluetooth power settings
  hardware.bluetooth.powerOnBoot = true;

  # Power button behavior: suspend on press (change to "ignore" or "poweroff" if preferred)
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
    HandleSuspendKey=suspend
    HandleLidSwitch=ignore
    IdleAction=ignore
  '';

  # CPU governor - balanced mode for efficiency while still responsive
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";  # Modern balanced scheduler-based governor
  };
}
