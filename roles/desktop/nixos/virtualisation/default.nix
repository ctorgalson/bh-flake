{ pkgs, ... }:

{
  imports = [
    ./windows-nvda-vm.nix
  ];

  # Docker support
  virtualisation.docker.enable = true;

  # QEMU/KVM with virt-manager support
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      swtpm.enable = true;  # TPM emulation for Windows 11
      # OVMF (UEFI firmware) is now included by default
    };
  };

  # Enable virt-manager GUI
  programs.virt-manager.enable = true;

  # Enable dnsmasq for libvirt's default network
  virtualisation.libvirtd.allowedBridges = [ "virbr0" ];

  # Enable USB redirection for guests
  virtualisation.spiceUSBRedirection.enable = true;

  # Add necessary packages
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    virtio-win  # Windows virtio drivers
  ];

  # Enable Windows NVDA VM helper scripts
  bhFlake.windowsNvdaVm.enable = true;
}
