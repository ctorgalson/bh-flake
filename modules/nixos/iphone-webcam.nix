{ config, pkgs, ... }:

{
  # 1. Install the client packages
  environment.systemPackages = with pkgs; [
    droidcam
    libimobiledevice # Required if you want to connect via USB
  ];

  # 2. Enable the kernel module for virtual video loopback
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  # Optional: Configure v4l2loopback settings so it labels the camera nicely
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=2 card_label="iPhone Webcam" exclusive_caps=1
  '';

  # 3. Enable usbmuxd daemon for iOS USB tethering/communication
  services.usbmuxd.enable = true;
}
