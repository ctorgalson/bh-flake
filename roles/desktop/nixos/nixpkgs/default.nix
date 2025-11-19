{ inputs, lib, pkgs, ... }:

let
  allowedUnfreePackages = [ "bws" "steam" "zoom-us" ];
in
{
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowedUnfreePackages;
  };
}
