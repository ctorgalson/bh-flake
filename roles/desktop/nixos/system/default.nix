{ inputs, lib, pkgs, ... }:

{
  system.autoUpgrade = {
    enable = true;
    dates = "08:35";
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
