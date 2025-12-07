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
    trusted-users = [ "@wheel" ];
    # Trust store paths signed by desktop hosts (for Colmena deployment)
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "framework13:LqlxIe8xSMi5P54352BZlb4JQNDWfABJgCjretPZPfs="
      "ser6:GlUy8CJNhbpCcSvVDcEiR7bI/9VQ+aBjrsqO8v2ZqQk="
    ];
  };
}

