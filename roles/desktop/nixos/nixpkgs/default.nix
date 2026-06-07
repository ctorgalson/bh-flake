{ inputs, lib, pkgs, ... }:

let
  allowedUnfreePackages = [ "bws" "spideroak" "steam" "zoom-us" ];
  # EOL, no upstream backports. Pulled in by bitwarden-desktop (hard-pinned in
  # both stable and unstable). Revisit on next nixpkgs upgrade.
  allowedInsecurePackages = [ "electron-39.8.10" ];
in
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowedUnfreePackages;
    permittedInsecurePackages = allowedInsecurePackages;
  };
}
