{ inputs, lib, pkgs, ... }:

{
  # Enable ARM emulation for cross-compilation to pi0
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.autoUpgrade = {
    enable = true;
    dates = "daily";
    flake = inputs.self.outPath;
    flags = [
      "--no-write-lock-file"
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    randomizedDelaySec = "45min";
  };
}
