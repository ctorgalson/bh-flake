{ inputs, lib, pkgs, ... }:

let
  allowedUnfreePackages = [ "bws" "spideroak" "steam" "unifi" "zoom-us" ];
in
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowedUnfreePackages;
  };
}
