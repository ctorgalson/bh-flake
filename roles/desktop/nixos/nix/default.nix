{ inputs, lib, pkgs, ... }:

{
  nix.gc = {
    automatic = true;
    dates = "10:00";
    options = "--delete-older-than 3d";
    randomizedDelaySec = "45min";
  };

  nix.optimise = {
    automatic = true;
  };

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
}

