{ inputs, lib, pkgs, ... }:

{
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
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

