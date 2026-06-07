{ config, pkgs, ... }:

{
  # Laptop power management - balance responsiveness with battery life

  # Allow USB autosuspend but with reasonable timeouts (2 seconds)
  boot.kernelParams = [ "usbcore.autosuspend=2" ];

  # Configure device wake capabilities - laptop uses built-in keyboard/trackpad
  services.udev.extraRules = ''
    # Enable wake from USB input devices
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usbhid", ATTR{power/wakeup}="enabled"

    # Allow USB autosuspend but keep input devices responsive
    ACTION=="add", SUBSYSTEM=="usb", DRIVER=="usbhid", ATTR{power/autosuspend_delay_ms}="2000"
  '';

  # Bluetooth power settings
  hardware.bluetooth.powerOnBoot = true;

  # CPU governor - balanced, power-saving friendly
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";  # Balanced scheduler-based governor

    # Additional laptop power saving
    powertop.enable = true;
  };

  # Disable power-profiles-daemon (conflicts with TLP)
  services.power-profiles-daemon.enable = false;

  # TLP for advanced laptop power management
  services.tlp = {
    enable = true;
    settings = {
      # CPU settings
      CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";

      # Enable aggressive power saving on battery
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";

      # Platform profile
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # USB autosuspend - enable but exclude input devices
      USB_AUTOSUSPEND = 1;

      # Keep system responsive
      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;
    };
  };
}
